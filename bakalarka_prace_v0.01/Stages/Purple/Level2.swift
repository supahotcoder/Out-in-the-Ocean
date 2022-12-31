//
//  Level2.swift
//  bakalarka_prace_v0.01
//
//  Created by Jan Czerny on 25/02/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level2: GameScene {

    
    override func didMove(to view: SKView) {
        // Crystal effect
        let crystals = SKEmitterNode(fileNamed: "CrystalEffect")!
        crystals.position = CGPoint(x: 0,y: 0)
        crystals.zPosition = 4
        self.addChild(crystals)
        super.didMove(to: view)
    }
    
    func gameOver() {
        GameSceneClass.haveDied = true
        playerNode?.physicsBody?.categoryBitMask = 0b0
        playerNode?.physicsBody?.contactTestBitMask = 0b0
        playerNode?.physicsBody?.collisionBitMask = 0b0
        playerNode?.run(SKAction.fadeOut(withDuration: 2))
        let end = SKEmitterNode(fileNamed: "Ending2")!
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let player: SKPhysicsBody
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyA
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyB
            otherNode = contact.bodyA
        } else {
            return
        }
        if let pl = entityManager.player?.component(ofType: FeedbackComponent.self) {
            if let bMask = bitmasks(rawValue: otherNode.categoryBitMask) {
                let fbText = pl.giveTouchFeedback(on: bMask)
                if (fbText != "") {
                    self.updateFeedbackText(with: fbText)
                }
                let palyerFbText = pl.givePlayerThought(on: bMask)
                if (palyerFbText != "") {
                    self.updatePlayerThoughtText(with: palyerFbText, displayIn: 0.5)
                }
            }
        }
    }
}
