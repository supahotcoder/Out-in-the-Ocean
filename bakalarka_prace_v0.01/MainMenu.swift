//
//  MainMenu.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 16/02/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    private var playButton: SKSpriteNode!
    private var playGameButton: SKNode!
    
    private var resetProgress: SKSpriteNode!
    
    private var level: String!
    
    override func didMove(to view: SKView) {
        level = "Level0"
        //Načtení posledního uloženého levelu
        if let lastLevel = UserDefaults.standard.string(forKey: "LastLevel"){
            //TESTING Level1_1
            level = "Level0"
        }
        
        playButton = childNode(withName: "playGame") as? SKSpriteNode
        playGameButton = SKSpriteNode(texture: SKTexture(imageNamed: "transp"), size: CGSize(width: 500, height: 200))
        playGameButton.zPosition = 10
        playGameButton.position = CGPoint(x: 0, y: 0)
        addChild(playGameButton)
        
        resetProgress = childNode(withName: "resetProgress") as? SKSpriteNode
    }
    
    private func touchAnimation(position: CGPoint) {
        let warp = SKEmitterNode(fileNamed: "Warping")
        warp?.zPosition = 4
        warp?.position = position
        self.addChild(warp!)
        let remove = SKAction.sequence([SKAction.wait(forDuration: 5),SKAction.removeFromParent()])
        warp?.run(remove)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.first?.location(in: playGameButton)
        touchAnimation(position: (touches.first?.location(in: playGameButton))!)
        if playButton.frame.contains(t!){
                buttonPressed(node: playButton)
            print("Launching Level \(String(describing: level))")
                if let scene = SKScene(fileNamed: level) {
                    self.removeAllActions()
                    self.removeAllChildren()
                    let transition:SKTransition = SKTransition.fade(withDuration: 2)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        //TODO: - Po testování nahodit zpátky na Level1_1
        if resetProgress.frame.contains(t!){
            buttonPressed(node: resetProgress)
            UserDefaults.standard.removeObject(forKey: "LastLevel")
            level = "Level1_3"
            
        }
    }
    
    private func buttonPressed(node: SKSpriteNode) {
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        node.run(SKAction.sequence([fadeOut,fadeIn]))
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
