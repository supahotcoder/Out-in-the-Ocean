//
//  Level1-1.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 31/03/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level1_1: Level1 {
    
    override func didMove(to view: SKView) {
        // LEVEL FUNCTIONALITY
        self.background = childNode(withName: "pozadi") as? SKSpriteNode
        self.name = "Level1_1"
        super.didMove(to: view)
       
        // TODO: - override name, background, start point, etc.
        #warning("Level1_1 setup missing")
    }
    
    override func nextLevel() {
        if let scene = SKScene(fileNamed: "Level1_3") {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: "Level1_3")
            self.view?.presentScene(scene)
        }
    }
    
}
