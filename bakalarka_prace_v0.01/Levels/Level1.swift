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
        updateGoalText(with: "MULTIPLE \n WANDER \n TESTING", around: playerNode!)
        
        //WANDER SETUP
        entityManager.loadWander()
        entityManager.loadWander()
        entityManager.loadWander()
        entityManager.loadWander()
        entityManager.loadWander()


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
    override func willMove(from view: SKView) {
        print("cleanUP")
    }
    
    //MARK: - GAMEOVER
     func gameOver() {
        if let scene = SKScene(fileNamed: "Level1") {
            self.removeAllActions()
            self.removeAllChildren()
            view!.presentScene(scene, transition: SKTransition.fade(with: .black, duration: 1.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
