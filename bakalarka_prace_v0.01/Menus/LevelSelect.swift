//
//  LevelSelect.swift
//  bakalarka_prace_v0.01
//
//  Created by Jan Czerny on 23/02/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class LevelSelect: MenuEssential {
    
    private var Level1_1: SKSpriteNode!
    private var Level1_2: SKSpriteNode!
    private var Level1_3: SKSpriteNode!
    
    private var Level2_1: SKSpriteNode!
    private var Level2_2: SKSpriteNode!
    private var Level2_3: SKSpriteNode!
    
    private var Level3_1: SKSpriteNode!
    private var Level3_2: SKSpriteNode!
    private var Level3_3: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        Level1_1 = childNode(withName: "Level1_1") as? SKSpriteNode
        Level1_2 = childNode(withName: "Level1_2") as? SKSpriteNode
        Level1_3 = childNode(withName: "Level1_3") as? SKSpriteNode
        
        Level2_1 = childNode(withName: "Level2_1") as? SKSpriteNode
        Level2_2 = childNode(withName: "Level2_2") as? SKSpriteNode
        Level2_3 = childNode(withName: "Level2_3") as? SKSpriteNode
        
        Level3_1 = childNode(withName: "Level3_1") as? SKSpriteNode
        Level3_2 = childNode(withName: "Level3_2") as? SKSpriteNode
        Level3_3 = childNode(withName: "Level3_3") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first?.location(in: scene!){
            touchAnimation(position: (touches.first?.location(in: scene!))!)
            if Level1_1.frame.contains(t){
                launchScene("Level1_1")
            }
            else if Level1_2.frame.contains(t){
                launchScene("Level1_2")
            }
            else if Level1_3.frame.contains(t){
                launchScene("Level1_3")
            }
            else if Level2_1.frame.contains(t){
                launchScene("Level2_1")
            }
            else if Level2_2.frame.contains(t){
                launchScene("Level2_2")
            }
            else if Level2_3.frame.contains(t){
                launchScene("Level2_3")
            }
            else if Level3_1.frame.contains(t){
                launchScene("Level3_1")
            }
            else if Level3_2.frame.contains(t){
                launchScene("Level3_2")
            }
            else if Level3_3.frame.contains(t){
                launchScene("Level3_3")
            }
        }
    }
    
    private func launchScene(_ levelName: String) {
        print("Launching \(levelName)")
        if let scene = SKScene(fileNamed: levelName) {
            self.removeAllActions()
            self.removeAllChildren()
            let transition:SKTransition = SKTransition.fade(withDuration: 2)
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
}
