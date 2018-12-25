//
//  Level1.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 21/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level1 : GameScene{
    
    override func didMove(to view: SKView) {
        // BACKGROUND BOUNDARY
        background = childNode(withName: "pozadi") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 150,y: (self.scene?.position.y)!)
        
        // první nastavíme physicsBody až poté voláme super.didMove
        super.didMove(to: view)
        
        //SEARCHER SETUP
        entityManager.loadSearcher()
        // ACTIVE BACKGROUND SETUP
        activeBack = entityManager.loadActiveBackground()!
        
        // Bubble effect
        let bubblesback = SKEmitterNode(fileNamed: "BubbleEffect")!
        let bubblesfront = SKEmitterNode(fileNamed: "BubbleEffect")!
        bubblesback.position = CGPoint(x: 0,y: 0)
        bubblesfront.position = CGPoint(x: 0,y: 0)
        bubblesfront.zPosition = 3
        self.addChild(bubblesfront)
        self.addChild(bubblesback)
        
        //TEXT SETUP
        updateGoalText(with: "FIND \n THEM \n TESTING", around: playerNode!)
        
        //WANDER SETUP
        let msgs = ["Hi" , "...", "Hello stranger" ,"It's getting greener", "Welcome Traveler", "Something,\n is not right in there" ,"Not me", "Did you found\n what you've been looking for?", "Don't bother me"]
        let warning = ["Get out", "Beware","Watch out", "Booo"]
        entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(warningMsgs: warning)
        entityManager.loadWander()


//        let backgroundSound = SKAudioNode(fileNamed: "level1_jungleVibes - 24.12.18 16.03.wav")
        self.run(SKAction.playSoundFileNamed("level1_jungleVibes - 24.12.18 16.03.wav", waitForCompletion: false))
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
        else {
            return
        }
        
        if otherNode.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            entityManager.remove(entity: activeBack)
            activeBack = nil
            
        }

        if otherNode.node?.physicsBody?.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        }
    }
    
    //MARK: - GAMEOVER
     func gameOver() {
        //
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
        joystickFrame?.removeFromParent()
        entityManager.gameOver = true
        //přepnutí scény po End scene
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) {
            if let scene = SKScene(fileNamed: "Level1") {
                self.removeAllActions()
                self.removeAllChildren()
                self.view?.presentScene(scene)
            }
        }
     
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
