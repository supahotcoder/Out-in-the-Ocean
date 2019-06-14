//
//  Level1.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 21/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Level1 : GameScene{
    
    let effectNode = SKEffectNode()
    
    var c1 : Collectible!
    var c2 : Collectible!
    var c3 : Collectible!
    var c4 : Collectible!
    
    var warperNode: SKSpriteNode!
    
    var collectibleCount = 0
    
    override func didMove(to view: SKView) {
        // BACKGROUND BOUNDARY
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 150,y: (self.scene?.position.y)!)
        
        // první nastavíme physicsBody až poté voláme super.didMove
        super.didMove(to: view)

        // Bubble effect
        let bubblesback = SKEmitterNode(fileNamed: "BubbleEffect")!
        let bubblesfront = SKEmitterNode(fileNamed: "BubbleEffect")!
        
        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        bubblesback.particlePositionRange = backgroundRange
        bubblesfront.particlePositionRange = backgroundRange
        
        bubblesback.position = CGPoint(x: 0,y: 0)
        bubblesfront.position = CGPoint(x: 0,y: 0)
        bubblesfront.zPosition = 3
        self.addChild(bubblesfront)
        self.addChild(bubblesback)
    }
    
    //MARK: - TOUCHES
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    //MARK: - COLISIONS
     func didBegin(_ contact: SKPhysicsContact) {
        let player : SKPhysicsBody
        let otherNode : SKPhysicsBody
        
        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyA
            otherNode = contact.bodyB
        }
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyB
            otherNode = contact.bodyA
        }
        // WARPER CONTACT
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            warp(contact: contact,otherNode: contact.bodyA.node)
            return
        }
        else if contact.bodyA.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            warp(contact: contact,otherNode: contact.bodyB.node)
            return
        }
        else {
            return
        }
        
        if otherNode.categoryBitMask == bitmasks.collectible.rawValue {
            // preparing for the warp
            if collectibleCount == 2{
                playerNode?.run(SKAction.colorize(with: .green, colorBlendFactor: 0.9, duration: 3))
                effectNode.filter = CIFilter(name: "CITorusLensDistortion", parameters: ["inputRadius": 20,"inputRefraction": 3])
            }
            else{
               playerNode?.run(SKAction.colorize(with: UIColor(red: CGFloat(200 - collectibleCount * 200) / 255, green: CGFloat(0 + collectibleCount * 200) / 255, blue: CGFloat(200 - collectibleCount * 200) / 255, alpha: 1), colorBlendFactor: 1, duration: 3))
            }
            
            switch otherNode.node?.name{
                case "c1": entityManager.remove(entity: c1)
                case "c2": entityManager.remove(entity: c2)
                case "c3": entityManager.remove(entity: c3)
                case "c4": entityManager.remove(entity: c4)
                default:
                    break
            }
            collectibleCount += 1
        }

        else if otherNode.categoryBitMask == bitmasks.activeBackground.rawValue{
            //NOTICE: - Due to some unexplainable bug otherNode.node?.position
            //          would return (NaN,NaN), that's why is contactPoint is used instead
            print(collectibleCount)
            if collectibleCount == 2{
                warp(contact: contact, otherNode: player.node)
                return
            }
            else if collectibleCount == 3{
                nextLevel()
                return
            }
            else {
                warp(contact: contact)
            }
            playerNode?.physicsBody?.applyImpulse(-(playerNode?.physicsBody?.velocity)!)
        }

        else if otherNode.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        }
    }
    
    func warp(contact: SKPhysicsContact, otherNode: SKNode? = nil) {
        let warp = SKEmitterNode(fileNamed: "Warping")!
        let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
        warp.position = contact.contactPoint
        warp.zPosition = 3
        self.addChild(warp)
        warp.run(removeWarp)

        if otherNode != nil{
            let warped = warp
            warped.position = CGPoint.randomPosition(x: -840...840,y: -640...640)
            let pos = warped.position
            
            // první se vynoří animace a až za 1.5s teleportovaný objekt
            var teleport = SKAction.move(to: pos, duration: 0)
            if otherNode?.physicsBody?.categoryBitMask != bitmasks.player.rawValue{
                let void = CGPoint(x: 5000, y: 5000)
                teleport = SKAction.sequence([SKAction.move(to: void, duration: 0),SKAction.wait(forDuration: 1.5),SKAction.move(to: pos, duration: 0)])
            }
            otherNode?.run(teleport)
        }
        let tel = CGPoint.randomPosition(x: -840...840,y: -640...640)

        warperNode.run(SKAction.move(to: tel, duration: 0))

    }
    
    //MARK: - GAMEOVER
     func gameOver() {
        playerNode?.physicsBody?.categoryBitMask = 0b0
        playerNode?.physicsBody?.contactTestBitMask = 0b0
        playerNode?.physicsBody?.collisionBitMask = 0b0
        playerNode?.run(SKAction.fadeOut(withDuration: 2))
        let end = SKEmitterNode(fileNamed: "Ending")!
        end.position = (playerNode?.position)!
        end.zPosition = 6
        self.addChild(end)
        let seconds = CGFloat(end.numParticlesToEmit) / end.particleBirthRate + end.particleLifetime + end.particleLifetimeRange / 2
        self.scene?.run(SKAction.fadeOut(withDuration: TimeInterval(seconds)))
        //zrušení pohybu a zpráv
        joystickNode?.removeFromParent()
        entityManager.gameOver = true
        //přepnutí scény po End scene
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) {
            if let scene = SKScene(fileNamed: self.name!) {
                self.removeAllActions()
                self.removeAllChildren()
                self.view?.presentScene(scene)
            }
        }
    }
    
    func nextLevel(){
//        if let scene = SKScene(fileNamed: "Level2") {
//            self.removeAllActions()
//            self.removeAllChildren()
//            saveLevel(levelName: "Level2")
//            self.view?.presentScene(scene)
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
