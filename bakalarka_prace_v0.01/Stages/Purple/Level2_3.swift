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

class Level2_3: Level2 {
    
    override func didMove(to view: SKView) {
        self.name = "Level2"
        // BACKGROUND BOUNDARY
        background = childNode(withName: "pozadi") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 150,y: (self.scene?.position.y)!)
        
        super.didMove(to: view)
        
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
    
    override func gameOver() {
        
    }
    
    override func didBegin(_ contact: SKPhysicsContact) {
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
