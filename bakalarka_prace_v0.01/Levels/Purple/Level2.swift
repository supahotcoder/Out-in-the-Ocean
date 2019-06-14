//
//  Level2.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 17/02/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Level2: GameScene {
    
    override func didMove(to view: SKView) {
        self.name = "Level2"
        // BACKGROUND BOUNDARY
        background = childNode(withName: "pozadi") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 150,y: (self.scene?.position.y)!)
        
        super.didMove(to: view)
        
        // Crystal effect
        let crystals = SKEmitterNode(fileNamed: "CrystalEffect")!
        let fluidCrystals = SKEmitterNode(fileNamed: "FluidEffect")!
        crystals.position = CGPoint(x: 0,y: 0)
        fluidCrystals.position = CGPoint(x: 0, y: 0)
        crystals.zPosition = 4
        fluidCrystals.zPosition = 2
        self.addChild(crystals)
        self.addChild(fluidCrystals)
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
    
    func gameOver() {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
