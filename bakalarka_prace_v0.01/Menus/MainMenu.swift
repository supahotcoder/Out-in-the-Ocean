//
//  MainMenu.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 16/02/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class MainMenu: MenuEssential {
    
    private var playButton: SKSpriteNode!
    private var playGameButton: SKNode!
    
    private var resetProgress: SKSpriteNode!
    private var selectLevel: SKSpriteNode!
    
    private var level: String!
    
    override func didMove(to view: SKView) {
        // MUSIC SETUP
        do {
            try backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "main-menu", withExtension: "wav")!)
            backgroundMusicPlayer!.numberOfLoops = -1
            backgroundMusicPlayer!.prepareToPlay()
            backgroundMusicPlayer!.play()
        }
        catch{}
        
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
        selectLevel = childNode(withName: "selectLevel") as? SKSpriteNode
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first?.location(in: playGameButton){
            touchAnimation(position: (touches.first?.location(in: playGameButton))!)
            if playButton.frame.contains(t){
                buttonPressed(node: playButton)
                backgroundMusicPlayer?.pause()
                backgroundMusicPlayer?.stop()
                print("Launching Level \(String(describing: level))")
                    if let scene = SKScene(fileNamed: level) {
                        self.removeAllActions()
                        self.removeAllChildren()
                        let transition:SKTransition = SKTransition.fade(withDuration: 2)
                        self.view?.presentScene(scene, transition: transition)
                    }
                }
            //TODO: - Po testování nahodit zpátky na Level1_1
            if resetProgress.frame.contains(t){
                buttonPressed(node: resetProgress)
                UserDefaults.standard.removeObject(forKey: "LastLevel")
                level = "Level1_3"
                
            }
            if selectLevel.frame.contains(t){
                buttonPressed(node: selectLevel)
                backgroundMusicPlayer?.stop()
                if let scene = SKScene(fileNamed: "LevelSelect") {
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        scene.scaleMode = .resizeFill
                    }
                    else{
                        scene.scaleMode = .fill
                    }
                    self.removeAllActions()
                    self.removeAllChildren()
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}
