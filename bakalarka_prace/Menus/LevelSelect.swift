//
//  LevelSelect.swift
//  bakalarka_prace_v0.01
//
//  Created by Jan Czerny on 23/02/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class LevelSelect: MenuEssential {
    
    private var level1_1: SKSpriteNode!
    private var level1_2: SKSpriteNode!
    private var level1_3: SKSpriteNode!
    
    private var level2_1: SKSpriteNode!
    private var level3_1: SKSpriteNode!
    private var level4_1: SKSpriteNode!

    private var level0_1: SKSpriteNode!
    private var level1_2S: SKSpriteNode!
    private var level2_1S: SKSpriteNode!
    private var level3_1S: SKSpriteNode!

    private var backButton: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        do {
              try backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "level-select", withExtension: "wav")!)
              backgroundMusicPlayer!.numberOfLoops = -1
              backgroundMusicPlayer!.prepareToPlay()
              backgroundMusicPlayer!.play()
        }catch{
            print("AVAudioPlayer crashed")
        }
        
//        Mozna oprava pokud je simulator spatne prizpusobeny (XCode 13.2.1 ma tuto chybu u simolatoru iPhone 11,12,13 PRO/MAX/MINI)
        print(UIScreen.main.bounds.size)
        print(self.scene!.size)
        var deviceSize = self.scene!.size//UIScreen.main.bounds.size
//        POKUD TESTUJETE V SIMULATORU A MENU SE ZOBRAZUJE SPATNE ODKOMENTUJTE NASLEDUJICI KOD
//        if isRunningInSimulator(){
//            deviceSize = deviceSize.width > self.scene!.size.width ? deviceSize : self.scene!.size
//        }
        
        let heightAdjust: CGFloat = 3
        let widthAdjust: CGFloat = 3
//        let levelBackgroundAdjust = 1.75
        level1_1 = childNode(withName: "Level1_1") as? SKSpriteNode
        level1_1.position = CGPoint(x: -(deviceSize.width / widthAdjust), y: deviceSize.height / heightAdjust)
        level1_2 = childNode(withName: "Level1_2") as? SKSpriteNode
        level1_2.position = CGPoint(x: 0, y: deviceSize.height / heightAdjust)
        level1_3 = childNode(withName: "Level1_3") as? SKSpriteNode
        level1_3.position = CGPoint(x: (deviceSize.width / widthAdjust), y: deviceSize.height / heightAdjust)
        
        level2_1 = childNode(withName: "Level2_1") as? SKSpriteNode
        level2_1.position = CGPoint(x: -(deviceSize.width / widthAdjust), y: 0)
        level3_1 = childNode(withName: "Level3_1") as? SKSpriteNode
        level3_1.position = CGPoint(x: 0, y: 0)
        level4_1 = childNode(withName: "Level4_1") as? SKSpriteNode
        level4_1.position = CGPoint(x: (deviceSize.width / widthAdjust), y: 0)
        
        level0_1 = childNode(withName: "Level0_1") as? SKSpriteNode
        level0_1.position = CGPoint(x: -(deviceSize.width / widthAdjust), y: -(deviceSize.height / (heightAdjust + 1)))
        level1_2S = childNode(withName: "Level1_2S") as? SKSpriteNode
        level1_2S.position = CGPoint(x: -(deviceSize.width / widthAdjust), y: -(deviceSize.height / (heightAdjust - 0.5)))
        level2_1S = childNode(withName: "Level2_1S") as? SKSpriteNode
        level2_1S.position = CGPoint(x: 0, y: -(deviceSize.height / heightAdjust))
        level3_1S = childNode(withName: "Level3_1S") as? SKSpriteNode
        level3_1S.position = CGPoint(x: (deviceSize.width / widthAdjust), y: -(deviceSize.height / heightAdjust))

        backButton = childNode(withName: "Back") as? SKSpriteNode
        backButton.position = CGPoint(x: (deviceSize.width / 2) - (backButton.size.width) / 2, y: (deviceSize.height / 2) - (backButton.size.height) / 2)
        
        let borders = childNode(withName: "Borders") as? SKSpriteNode
        borders?.size = deviceSize
        let background = childNode(withName: "Background") as? SKSpriteNode
        background?.size = deviceSize
        let backgroundStructure = childNode(withName: "BackgroundStructure") as? SKSpriteNode
        backgroundStructure?.size = deviceSize
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first?.location(in: scene!){
            touchAnimation(position: (touches.first?.location(in: scene!))!)
            if level1_1.frame.contains(t){
                launchScene("Level1_1")
            }
            else if level1_2.frame.contains(t){
                launchScene("Level1_2")
            }
            else if level1_3.frame.contains(t){
                launchScene("Level1_3")
            }
            else if level2_1.frame.contains(t){
                launchScene("Level2_1")
            }
            else if level3_1.frame.contains(t){
                launchScene("Level3_1")
            }
            else if level4_1.frame.contains(t){
                launchScene("Level4_1")
            }
            else if level2_1S.frame.contains(t){
                launchScene("Level2_1S")
            }
            else if level3_1S.frame.contains(t){
                launchScene("Level3_1S")
            }
            else if level1_2S.frame.contains(t){
                launchScene("Level1_2S")
            }
            else if level0_1.frame.contains(t){
                launchScene("Level0_1")
            }
            else if backButton.frame.contains(t){
                if let scene = SKScene(fileNamed: "MainMenu") {
                    self.removeAllActions()
                    self.removeAllChildren()
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        scene.scaleMode = .resizeFill
                    } else {
                        scene.scaleMode = .fill
                    }
                    self.view?.presentScene(scene)
                }
            }
        }
    }
    
    private func launchScene(_ levelName: String) {
        print("Launching \(levelName)")
        backgroundMusicPlayer?.stop()
        if let scene = SKScene(fileNamed: levelName) {
            self.removeAllActions()
            self.removeAllChildren()
            let transition:SKTransition = SKTransition.fade(withDuration: 2)
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
}
