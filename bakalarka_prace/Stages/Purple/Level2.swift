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
    
    func gameOver(){
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
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
