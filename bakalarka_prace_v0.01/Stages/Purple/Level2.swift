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
          let fluidCrystals = SKEmitterNode(fileNamed: "FluidEffect")!
          crystals.position = CGPoint(x: 0,y: 0)
          fluidCrystals.position = CGPoint(x: 0, y: 0)
          crystals.zPosition = 4
          fluidCrystals.zPosition = 2
          self.addChild(crystals)
          self.addChild(fluidCrystals)
    }
    
    func gameOver() {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
