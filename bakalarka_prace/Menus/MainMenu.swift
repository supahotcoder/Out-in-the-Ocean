//
//  MainMenu.swift
//
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
    private var settingsButton: SKSpriteNode!
    private var settingsBox: SettingsBox!
    
    private var joystick: Joystick!
    
    private var level: String!
    private var canChooseLevel: Bool!
    
    private let lvlSelectionLabel: SKLabelNode = SKLabelNode(text: "You haven't unlocked level selection yet!")
    
    override func didMove(to view: SKView) {
//        detekce screenshotu, ktera povoli vyber urovni
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: .main) { notification in
                self.canChooseLevel = true
                UserDefaults.standard.set(true, forKey: "CanChooseLevel")
                
                self.selectLevel.run(.colorize(with: .clear, colorBlendFactor: 0, duration: 0))
                self.selectLevel.alpha = 1
        }
        
        
        lvlSelectionLabel.name = "UnlockedText"
        lvlSelectionLabel.zPosition = 30
        
        canChooseLevel = UserDefaults.standard.bool(forKey: "CanChooseLevel")
        let isGameFinished = UserDefaults.standard.bool(forKey: "finishedGame")

        var songName = "main-menu"

        if isGameFinished{
            songName = "main-menu-finished-game"
            if UserDefaults.standard.string(forKey: "LastLevel") == "MainMenu"{
                UserDefaults.standard.set("Level4_1", forKey: "LastLevel")
                UserDefaults.standard.set(true, forKey: "CanChooseLevel")
                UserDefaults.standard.synchronize()
            }
        }
        // MUSIC SETUP
        do {

            try backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: songName, withExtension: "wav")!)
            backgroundMusicPlayer!.numberOfLoops = -1
            backgroundMusicPlayer!.prepareToPlay()
            backgroundMusicPlayer!.play()
        }
        catch{
            print("AVAudioPlayer crashed")
        }
        
        level = "Level0"
        //Načtení posledního uloženého levelu
        if let lastLevel = UserDefaults.standard.string(forKey: "LastLevel"){
            level = lastLevel
        }
        //        Mozna oprava pokud je simulator spatne prizpusobeny (XCode 13.2.1 ma tuto chybu u simolatoru iPhone 11,12,13 PRO/MAX/MINI)
        var deviceSize = self.scene!.size//UIScreen.main.bounds.size
        var deviceBounds = self.scene!.frame//UIScreen.main.bounds
//        POKUD TESTUJETE V SIMULATORU A MENU SE ZOBRAZUJE SPATNE ODKOMENTUJTE NASLEDUJICI KOD
//        if isRunningInSimulator(){
//            deviceSize = deviceSize.width > self.scene!.size.width ? deviceSize : self.scene!.size
//            deviceBounds = deviceBounds.width > self.scene!.frame.width ? deviceBounds : self.scene!.frame
//        }
        
        playButton = childNode(withName: "playGame") as? SKSpriteNode
        playGameButton = SKSpriteNode(texture: SKTexture(imageNamed: "transp"), size: CGSize(width: 500, height: 200))
        playGameButton.zPosition = 10
        playGameButton.position = CGPoint(x: 0, y: 0)
        addChild(playGameButton)
        if isGameFinished{
            (playButton.childNode(withName: "playGameLabel") as? SKLabelNode)?.text = "Play Again"

        }
        
        resetProgress = childNode(withName: "resetProgress") as? SKSpriteNode
        selectLevel = childNode(withName: "selectLevel") as? SKSpriteNode

        playButton.position = CGPoint(x: 0, y: (deviceSize.height / 4))
        adjustLabelFontSizeToFitRect(labelNode: (playButton.children.first as? SKLabelNode)!, size: playButton.size)
        selectLevel.position = CGPoint(x: 0, y: 0)
        adjustLabelFontSizeToFitRect(labelNode: (selectLevel.children.first as? SKLabelNode)!, size: selectLevel.size)
        resetProgress.position = CGPoint(x: 0, y: -deviceSize.height / 4)
        adjustLabelFontSizeToFitRect(labelNode: (resetProgress.children.first as? SKLabelNode)!, size: resetProgress.size)
        if !canChooseLevel{
            selectLevel.run(.colorize(with: .darkGray, colorBlendFactor: 0.8, duration: 0))
            selectLevel.alpha = 0.6
        }
        
        settingsButton = childNode(withName: "settings") as? SKSpriteNode
        settingsButton.position = CGPoint(x: (deviceSize.width / 2) - (settingsButton.size.width) / 2, y: (deviceSize.height / 2) - (settingsButton.size.height) / 2)
        
        joystick = Joystick(screen: CGRect.zero, adjustment: CGFloat.zero)
        let isDynamicJoystick = UserDefaults.standard.bool(forKey: "joystickSettings")
        joystick.isDynamic = isDynamicJoystick
        settingsBox = SettingsBox(joystick: joystick, deviceBounds: deviceBounds)
        
        
        let dimmedCorners = childNode(withName: "dimmed_corners") as? SKSpriteNode
        dimmedCorners?.size = deviceSize
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let t = touches.first?.location(in: playGameButton){
            touchAnimation(position: (touches.first?.location(in: playGameButton))!)
            if settingsBox.active{
                settingsBox.didTouched(touches: touches, touchedIn: self.scene!)
            }
            else if playButton.frame.contains(t){
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
            else if resetProgress.frame.contains(t){
                buttonPressed(node: resetProgress)
                UserDefaults.standard.removeObject(forKey: "Level1_2S_by_player")
                UserDefaults.standard.removeObject(forKey: "Level2_1_side_story")
                UserDefaults.standard.removeObject(forKey: "LastLevel")
                UserDefaults.standard.removeObject(forKey: "finishedGame")
                UserDefaults.standard.removeObject(forKey: "Feedback")
                UserDefaults.standard.synchronize()
                level = "Level0"
            }
            else if selectLevel.frame.contains(t){
                if canChooseLevel{
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
                }else{
                    if !(scene?.childNode(withName: "UnlockedText")?.hasActions() ?? false){
                        addChild(lvlSelectionLabel)
                        lvlSelectionLabel.fontSize = (resetProgress.children[0] as! SKLabelNode).fontSize
                        
                        let textBackground = SKSpriteNode(color: UIColor.lightGray, size: CGSize(width: CGFloat(lvlSelectionLabel.frame.size.width * 1.1), height:CGFloat(lvlSelectionLabel.frame.size.height * 1.5)))
                        textBackground.position = CGPoint(x: 0, y: textBackground.size.height / 3)
                        textBackground.zPosition = -1
                        lvlSelectionLabel.addChild(textBackground)
                        
                        lvlSelectionLabel.run(.sequence([.wait(forDuration: 2.5),.fadeOut(withDuration: 0.5),.removeFromParent()]))
                    }
                }
            }
            else if settingsButton.frame.contains(t){
                settingsBox.showSettings(parentNode: self.scene!)
            }
        }
    }
}
