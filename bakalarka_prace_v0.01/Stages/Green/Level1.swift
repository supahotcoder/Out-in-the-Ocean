//
//  Level1.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Level1: GameScene {

    let effectNode = SKEffectNode()

    var warperNode: SKSpriteNode!

    var collectibleCount = 0

    override func didMove(to view: SKView) {
        // BACKGROUND BOUNDARY
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        ContactComponent.addCollisions(physicsBody: physicsBody!, bitmask: bitmasks.frame.rawValue)

        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 150, y: (self.scene?.position.y)!)

        // první nastavíme physicsBody až poté voláme super.didMove
        super.didMove(to: view)

        // Bubble effect
        let bubblesback = SKEmitterNode(fileNamed: "BubbleEffect")!
        let bubblesfront = SKEmitterNode(fileNamed: "BubbleEffect")!

        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        bubblesback.particlePositionRange = backgroundRange
        bubblesfront.particlePositionRange = backgroundRange

        bubblesback.position = CGPoint(x: 0, y: 0)
        bubblesfront.position = CGPoint(x: 0, y: 0)
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

    }

    func warp(contact: SKPhysicsContact, otherNode: SKNode?, customWarper: SKNode? = nil, teleportTo: CGPoint? = nil) {
        let warp = warpAnimation(position: contact.contactPoint)
        var tel = CGPoint.randomPosition(x: -840...840, y: -640...640)

        if otherNode != nil {
            let warped = warp
            if teleportTo != nil {
                warped.position = teleportTo!
                tel = teleportTo!
            } else {
                warped.position = CGPoint.randomPosition(x: -840...840, y: -640...640)
            }
            let pos = warped.position

            // první se vynoří animace a až za 1.5s teleportovaný objekt
            var teleport = SKAction.move(to: pos, duration: 0)
            if otherNode?.physicsBody?.categoryBitMask != bitmasks.player.rawValue {
                let void = CGPoint(x: 5000, y: 5000)
                teleport = SKAction.sequence([SKAction.move(to: void, duration: 0), SKAction.wait(forDuration: 1.5), SKAction.move(to: pos, duration: 0)])
                otherNode?.run(teleport)
            } else {
                playerNode?.run(teleport)
            }
        }

        if customWarper != nil {
            customWarper!.run(SKAction.move(to: tel, duration: 0))
        } else {
            warperNode.run(SKAction.move(to: tel, duration: 0))
        }
    }

    @discardableResult
    func warpAnimation(position: CGPoint) -> SKEmitterNode {
        let warp = SKEmitterNode(fileNamed: "Warping")!
        let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
        warp.position = position
        warp.zPosition = 3
        self.addChild(warp)
        warp.run(removeWarp)
        return warp
    }

    //MARK: - GAMEOVER
    func gameOver() {
        GameSceneClass.haveDied = true
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

    func nextLevel() {
    }

}
