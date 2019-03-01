//
//  GameScene.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 19.09.18.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer? = nil

protocol GameSceneProtocol {
    // implementace bude nutná u každého levelu solo
    //MARK: - GameOver, každý lvl handle sám
    func gameOver()
    func didBegin(_ contact: SKPhysicsContact)
}

typealias GameScene = GameSceneClass & GameSceneProtocol

class GameSceneClass: SKScene , SKPhysicsContactDelegate {
    
    // MARK: - GLOBAL VARS
    weak var playerNode : SKSpriteNode?
    private var joystick : Joystick!
    private var thumbstick : Thumbstick!
    private weak var joystickNode :SKSpriteNode?
    var entityManager : EntityManager!
    
    var joystickFrame: SKNode?
    weak var background : SKSpriteNode?
    var goals : [ActiveBackground] = [ActiveBackground]()
    
    var goalText = SKLabelNode()
    var storyText = SKLabelNode()
    var warningText = SKLabelNode()
    
    var playerSpawnPosition: CGPoint? = nil
    
    var lastUpdateTimeInterval: TimeInterval = 0
    
    //TESTING
    var pauseButton: SKSpriteNode?
    var resumeButton: SKSpriteNode?
    var restartButton: SKSpriteNode?
    var menuButton: SKSpriteNode?
    var pauseBackground: SKSpriteNode?
    
    
    // MARK: - DIDMOVE
    
    override func didMove(to view: SKView) {
        //NOTIFICATION SETUP
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: NSNotification.Name("gameInBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: NSNotification.Name("gameInView"), object: nil)
        
        //PHYSICS SETUP
        physicsWorld.contactDelegate = self

        #warning("joystick setup je úplně cancer PŘEDĚLAT")
        //JOYSTICK SETUP
        thumbstick = Thumbstick(image: "thumbstick", screen: UIScreen.main.bounds,device: UIDevice.current.userInterfaceIdiom)
        joystick = Joystick(screen: UIScreen.main.bounds,device: UIDevice.current.userInterfaceIdiom)
        joystickNode = joystick.node
        joystickNode?.addChild(thumbstick.node)
//        joystickNode?.alpha = CGFloat(0.4)
        joystickFrame = JoystickFrame(screen: UIScreen.main.bounds,device: UIDevice.current.userInterfaceIdiom).node
        joystickFrame?.addChild(joystickNode!)
        joystickFrame?.zPosition = 10
        
        // ENTITY SETUP
        entityManager = EntityManager(scene: self.scene!)
        
        //PLAYER SETUP
        if playerSpawnPosition == nil {
            playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 10,y: (self.scene?.position.y)!)
        }
        playerNode = entityManager.loadPlayer(position: playerSpawnPosition!)
        
        //CAMERA SETUP
        let cameraNode = SKCameraNode()
        cameraNode.addChild(joystickFrame!)
        self.camera = cameraNode
        addChild(cameraNode)
        camera!.movement(within: background!, cameraFocusOn: playerNode! , durationOfMovement: 0)
        camera?.scaleFor(device: UIDevice.current.userInterfaceIdiom)
        //DISPLAY TEXT SETUP
        goalText.fontName = "Futura-CondensedExtraBold"
        goalText.numberOfLines = 3
        
        warningText.fontName = "Futura-CondensedExtraBold"
        
        storyText.fontName = "Futura-CondensedExtraBold"
        storyText.numberOfLines = 5
        
        //Pause-menu setup
        pauseButton = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), color: .white, size: CGSize(width: UIScreen.main.bounds.size.width * 0.12, height: UIScreen.main.bounds.size.height * 0.15))
        pauseButton!.position = CGPoint(x: UIScreen.main.bounds.size.width / 2 - (pauseButton?.size.width)! / 2, y: UIScreen.main.bounds.size.height / 2 - (pauseButton?.size.height)! / 2)
        pauseButton!.zPosition = 10
        let lbl = SKLabelNode(text: "| |")
        lbl.position = CGPoint(x: 0, y: -5)
        lbl.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.fontName = "HelveticaNeue-CondensedBlack"
        lbl.fontSize = (pauseButton?.size.height)! / 2
        
        pauseButton!.addChild(lbl)
        camera?.addChild(pauseButton!)
        
        pauseGameSetup()
        print(UIScreen.main.bounds)

    }

    //MARK: - DISPLAY TEXT
    
    func updateGoalText(with text: String, around: SKNode) {
        addChild(goalText)
        updateText(with: text, label: &goalText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: goalText)
    }
    
    func updateStoryText(with text: String, around: SKNode) {
        addChild(storyText)
        updateText(with: text, label: &storyText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: goalText)
    }
    
    func updateWarningText(with text: String, around: SKNode) {
        addChild(warningText)
        updateText(with: text, label: &warningText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: goalText)
    }


    private func updateText(with text: String, label: inout SKLabelNode, around: SKNode, alligment: position) {
        label.text = text
        label.fontSize = 10
        label.zPosition = 5
        label.trackNode(node: around,labelAlligment: alligment.toCGPoint)
        label.alpha = 0
    }

    // MARK: - TOUCHES
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //stealth mode
            let t = touches.first?.location(in: camera!)
            if !(pauseButton?.isHidden)!,pauseButton!.frame.contains(t!){
                pauseGame()
            }
            else if !(resumeButton?.isHidden)!,(resumeButton?.frame.contains(t!))!{
                unPauseGame()
            }
            else if !(restartButton?.isHidden)!,(restartButton?.frame.contains(t!))!{
                #warning("SCENE MUST HAVE A SAME NAME AS IT'S CLASS")
                if let scene = SKScene(fileNamed: (self.scene?.name)!){
                    self.removeAllActions()
                    self.removeAllChildren()
                    self.view?.presentScene(scene)
                }
            }
            else if !(menuButton?.isHidden)!,(menuButton?.frame.contains(t!))!{
                if let scene = SKScene(fileNamed: "MainMenu") {
                    self.removeAllActions()
                    self.removeAllChildren()
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        scene.scaleMode = .resizeFill
                    }
                    else{
                        scene.scaleMode = .fill
                    }
                    self.view?.presentScene(scene)
                }
            }
            if let joystickNode = joystickNode {
                let loc = touch.location(in: joystickNode)
                joystick.didTouchJoystick(location: loc)
                if touch.tapCount == 2 && joystick.insideFrame{
                    joystick.stealthMode(playerNode: playerNode!)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: joystickNode!)
            //FIXME: - 45 degree too fast
            let length = position.length()//sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)
            joystick.turnAngle = angle
            //TESTING
            if  thumbstick.radius > length, joystick.insideFrame{//joystick.touchRadius > length {
                joystick.touch = position
                thumbstick.moveTo(position: position)
            }
            else if joystick.insideFrame {
                let pos = CGPoint(x: cos(angle) * joystick.touchRadius, y: sin(angle) * joystick.touchRadius)
                let thumb = CGPoint(x: cos(angle) * thumbstick.radius, y: sin(angle) * thumbstick.radius)
                joystick.touch  = pos
                thumbstick.moveTo(position: thumb)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.stopMovement()
        thumbstick.resetThumbstick()
        joystick.touch = CGPoint(x: 0, y: 0)
    }
    
    //MARK: - SOUNDS
    
    func backgroundMusic(fileName: String ,extension ex: String){
        do {
            if backgroundMusicPlayer == nil {
                try backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: ex)!)
                backgroundMusicPlayer!.numberOfLoops = 10
                backgroundMusicPlayer!.prepareToPlay()
                backgroundMusicPlayer!.play()
            }
        } catch {
        }
    }
    
    func soundEffect(filename: String) {
        self.run(SKAction.playSoundFileNamed(filename, waitForCompletion: false))
    }
    
    //MARK: - UPDATE
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        if (view?.isPaused)! {
            print("pauza")
            pauseGame()
        }
        
        joystick.movement(moveWith: playerNode!)
        camera?.movement(within: background!, cameraFocusOn: playerNode! , durationOfMovement: 0.3)
        entityManager.update(deltaTime)
        
    }
    
    private func pauseGameSetup() {
        pauseBackground = SKSpriteNode(color: .darkGray, size: UIScreen.main.bounds.size)
        pauseBackground?.alpha = 0.5
        
        let buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: CGSize(width: 200, height: 80))
        let labelBlueprint = SKLabelNode(text: "")
        labelBlueprint.position = CGPoint(x: 0, y: -5)
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        
        resumeButton = buttonBlueprint.copy() as? SKSpriteNode
        resumeButton?.position = CGPoint(x: 0, y: UIScreen.main.bounds.height / 4)
        resumeButton?.zPosition = 10
        labelBlueprint.text = "Resume"
        resumeButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        resumeButton?.isHidden = true
        
        restartButton = buttonBlueprint.copy() as? SKSpriteNode
        restartButton?.position = CGPoint(x: 0, y: 0)
        labelBlueprint.text = "Restart"
        restartButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        restartButton?.zPosition = 10
        restartButton?.isHidden = true
        
        menuButton = buttonBlueprint.copy() as? SKSpriteNode
        menuButton?.position = CGPoint(x: 0, y: -UIScreen.main.bounds.height / 4)
        labelBlueprint.text = "Menu"
        menuButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        menuButton?.zPosition = 10
        menuButton?.isHidden = true
    }
    
     func pauseGame() {
        pauseButton?.isHidden = true
        restartButton?.isHidden = false
        resumeButton?.isHidden = false
        menuButton?.isHidden = false
        camera?.addChild(pauseBackground!)
        camera?.addChild(resumeButton!)
        camera?.addChild(restartButton!)
        camera?.addChild(menuButton!)
        //pause for gameplaykit driven entities
        let gkDriven = entityManager.entitiesWithMoveComponent()
        gkDriven.forEach { (x) in x.delegate = nil}
        scene?.isPaused = true
    }
    
    func unPauseGame() {
        pauseButton?.isHidden = false
        restartButton?.isHidden = true
        resumeButton?.isHidden = true
        menuButton?.isHidden = true
        pauseButton?.alpha = 1
        resumeButton?.removeFromParent()
        restartButton?.removeFromParent()
        menuButton?.removeFromParent()
        pauseBackground?.removeFromParent()
        let gkDriven = entityManager.entitiesWithMoveComponent()
        gkDriven.forEach { (x) in
            let resetMovement = SKAction.run {x.resetAgentDelegate()}
            self.run(resetMovement)
        }
        scene?.isPaused = false
    }
    
    func saveLevel(levelName: String) {
        UserDefaults.standard.set(levelName, forKey: "LastLevel")
        UserDefaults.standard.synchronize()
    }
    
    
    //MARK: - Interruption handling
    @objc func applicationWillResignActive() {
        unPauseGame()
        pauseGame()
        view?.isPaused = !(view?.isPaused)!
    }
    
    @objc func applicationDidBecomeActive() {
        view?.isPaused = !(view?.isPaused)!
        unPauseGame()
        pauseGame()
    }
    
}
