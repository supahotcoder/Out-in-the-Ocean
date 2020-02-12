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
    weak var joystickNode :SKSpriteNode?
    var entityManager : EntityManager!
    // static kvuli tomu at nemame vice instantci audioPrehravacu
    private static var backgroundMusicPlayer: AVAudioPlayer? = nil

    var background : SKSpriteNode?
    var goals : [ActiveBackground] = [ActiveBackground]()
    
    var goalText = SKLabelNode()
    #warning("Delete or reimplement StoryComponent")
    //#error("When story text is about to be selected: pause, focus etc.")
    var storyText = SKLabelNode()
    var warningText = SKLabelNode()
    
    var playerSpawnPosition: CGPoint? = nil
    
    var lastUpdateTimeInterval: TimeInterval = 0
    var focusNodes: Queue<SKSpriteNode?> = Queue<SKSpriteNode?>()
    var focusTimes: Queue<TimeInterval> = Queue<TimeInterval>()

    static var haveDied = false
    
    private var pauseButton: SKSpriteNode?
    private var resumeButton: SKSpriteNode?
    private var restartButton: SKSpriteNode?
    private var menuButton: SKSpriteNode?
    private var pauseBackground: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        //RESET MUSIC
        GameSceneClass.backgroundMusicPlayer?.pause()
        print(GameSceneClass.haveDied)
        if !GameSceneClass.haveDied{
            GameSceneClass.backgroundMusicPlayer?.stop()
            GameSceneClass.backgroundMusicPlayer = nil
        }
        super.init(coder: aDecoder)
    }
    
    // MARK: - DIDMOVE
    
    override func didMove(to view: SKView) {
        //NOTIFICATION SETUP
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: NSNotification.Name("gameInBackground"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: NSNotification.Name("gameInView"), object: nil)
        
        //PHYSICS SETUP
        physicsWorld.contactDelegate = self
        
        //Device adjustments -> (iPhone,iPad)
        let device = UIDevice.current.userInterfaceIdiom
        let screen = UIScreen.main.bounds
        let adjustment = deviceAdjustments(device, screen)
        
        //JOYSTICK SETUP
        joystick = Joystick(screen: screen, adjustment: adjustment)
        joystickNode = joystick.node
        joystickNode?.addChild(joystick.thumbstick.node)
        joystickNode?.zPosition = 10
        
        //ENTITY SETUP
        entityManager = EntityManager(scene: self.scene!)
        
        //PLAYER SETUP
        if playerSpawnPosition == nil {
            playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 10,y: (self.scene?.position.y)!)
        }
        playerNode = entityManager.loadPlayer(position: playerSpawnPosition!)
        
        //CAMERA SETUP
        let cameraNode = SKCameraNode()
        cameraNode.addChild(joystickNode!)
        self.camera = cameraNode
        addChild(cameraNode)
        camera!.movement(within: background!, cameraFocusOn: playerNode! , durationOfMovement: 0)
        camera?.scaleFor(device: device)
        
        //DISPLAY TEXT SETUP
        goalText.fontName = "Futura-CondensedExtraBold"
        goalText.numberOfLines = 3
        
        warningText.fontName = "Futura-CondensedExtraBold"
        
        storyText.fontName = "Futura-CondensedExtraBold"
        storyText.numberOfLines = 5

        //Pause-menu setup
        pauseButton = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), color: .white, size: CGSize(width: screen.width * 0.12, height: screen.height * 0.15))
        pauseButton!.position = CGPoint(x: screen.width / 2 - (pauseButton?.size.width)! / 2, y: screen.height / 2 - (pauseButton?.size.height)! / 2)
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

        if (GameSceneClass.haveDied) {
            if let feedback = loadFeedback() {
                updateFeedbackText(with: feedback)
            }
        }
        // RESETING DUE TO ALIVE CONDITION
        GameSceneClass.haveDied = false
    }

    //MARK: - MOVEMENT FUNCTIONS

    func moveInDirection(direction: CGPoint, pulseForce: CGVector, with: SKSpriteNode) {
        with.physicsBody?.applyImpulse(pulseForce, at: direction)
    }

    func changeLevelGravity(gravity: CGVector) {
        self.physicsWorld.gravity = gravity
    }

    func move(with: SKSpriteNode,towards: SKSpriteNode, pulseForce: CGVector) {
        with.physicsBody?.applyImpulse(pulseForce, at: towards.position)
    }

    //MARK: - DISPLAY TEXT
    
    func updateGoalText(with text: String, around: SKNode, displayIn: Double=1, fadeOut: Double=2) {
        var textNode = goalText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        if (focusTimes.isEmpty) {
            displayText(displayIn: displayIn, fadeOut: fadeOut, label: textNode, around: around, alligment: .rightTop)
        }
        else{
            let timeToWait = focusTimes.front! - Date().timeIntervalSince1970
            print(timeToWait)
            displayText(displayIn: displayIn + timeToWait, fadeOut: fadeOut + timeToWait, label: textNode, around: around, alligment: .rightTop)
        }
    }

    func updateFeedbackText(with text: String) {
        var textNode = goalText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        displayText(displayIn: 0.1, fadeOut: 0.5, label: textNode, around: playerNode!, alligment: .onEntity)
    }

    @discardableResult
    func updateStoryText(with text: String, around: SKNode, displayIn: Double=1, fadeOut: Double=2, timeToFocusOn: Double?=nil) -> SKLabelNode {
        var textNode = storyText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        displayText(displayIn: displayIn, fadeOut: fadeOut, label: textNode, around: around, alligment: .rightBottom)
        focusOnNode(node: around, timeToFocusOn: timeToFocusOn ?? TimeInterval(text.count / 6))
        disableMovement()
        return textNode
    }
    
    func updateWarningText(with text: String, around: SKNode, displayIn: Double=0.5, fadeOut: Double=1) {
        var textNode = warningText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        displayText(displayIn: displayIn, fadeOut: fadeOut, label: textNode, around: around, alligment: .leftBottom)
    }
    
    func focusOnNode(node: SKNode, timeToFocusOn: TimeInterval) {
        focusNodes.enqueue(node as? SKSpriteNode)
        if (focusTimes.isEmpty){
            focusTimes.enqueue(Date().timeIntervalSince1970 + timeToFocusOn)
        }
        else {
            let timeOffset = abs(Date().timeIntervalSince1970 - focusTimes.last!)
            focusTimes.enqueue(Date().timeIntervalSince1970 + timeToFocusOn + timeOffset)
        }
    }
    
    func focusOnNodes(nodes: [SKNode], timesToFocusOn: [TimeInterval]) {
        if (nodes.count == timesToFocusOn.count){
            for (node, timeToFocusOn) in zip(nodes, timesToFocusOn) {
                focusNodes.enqueue(node as? SKSpriteNode)
                focusTimes.enqueue(Date().timeIntervalSince1970 + timeToFocusOn)
            }
        }
    }


    private func updateText(with text: String, label: inout SKLabelNode) {
        addChild(label as SKNode)
        label.text = text
        label.fontSize = 10
        label.zPosition = 5
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
            joystick.didTouchJoystick(location: t!)
            if touch.tapCount == 2 && joystick.insideFrame{
                joystick.stealthMode(playerNode: playerNode!)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: joystickNode!)
            let length = position.length()
            let angle = atan2(position.y, position.x)
            joystick.turnAngle = angle
            
            if  joystick.thumbstick.radius > length, joystick.insideFrame{
                joystick.touch = position
            }
            else if joystick.insideFrame {
                let pos = CGPoint(x: cos(angle) * joystick.touchRadius, y: sin(angle) * joystick.touchRadius)
                joystick.touch  = pos
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.stopMovement()
    }
    
    func disableMovement(){
        joystick.stopMovement()
        joystickNode?.isPaused = true
        joystickNode?.isHidden = true
        joystickNode?.removeFromParent()
    }
    
    func enableMovement(){
        joystickNode?.isPaused = true
        joystickNode?.isHidden = false
        camera?.addChild(joystickNode!)
    }
    
    //MARK: - SOUNDS
    
    func backgroundMusic(fileName: String ,extension ex: String){
        do {
            if GameSceneClass.backgroundMusicPlayer == nil {
                try GameSceneClass.backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: ex)!)
                GameSceneClass.backgroundMusicPlayer!.numberOfLoops = -1
                GameSceneClass.backgroundMusicPlayer!.prepareToPlay()
                GameSceneClass.backgroundMusicPlayer!.play()
            }
            else{
                GameSceneClass.backgroundMusicPlayer!.prepareToPlay()
                GameSceneClass.backgroundMusicPlayer!.play()
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
            pauseGame()
        }
        
        joystick.movement(moveWith: playerNode!)
        if (!focusTimes.isEmpty && Date().timeIntervalSince1970 >= focusTimes.front!){
            focusTimes.dequeue()
            focusNodes.dequeue()
            if (focusNodes.isEmpty){
                enableMovement()
            }
        }
        
        if (focusNodes.isEmpty){
            camera?.movement(within: background!, cameraFocusOn: playerNode! , durationOfMovement: 0.3)
        }
        else{
            camera?.movement(within: background!, cameraFocusOn: focusNodes.front!! , durationOfMovement: 0.3)
        }
        entityManager.update(deltaTime)
        
    }
    
    func runInBackground<T>(delay: Double, function: @escaping () -> T, completion: (() -> T)? = nil){
        DispatchQueue.global(qos: .background).async {
            function()
            if let afterFunc = completion{
                let wrapedFunc: () -> Void = {() in afterFunc()}
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: wrapedFunc)
            }
        }
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
         GameSceneClass.backgroundMusicPlayer?.pause();
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
        GameSceneClass.backgroundMusicPlayer?.play();
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
    
    //MARK: - Saving/Loading from device app-memory
    
    func saveLevel(levelName: String) {
        UserDefaults.standard.set(levelName, forKey: "LastLevel")
        UserDefaults.standard.synchronize()
    }

    func saveFeedback(feedback: String) {
        UserDefaults.standard.set(feedback, forKey: "Feedback")
        UserDefaults.standard.synchronize()
    }

    func loadFeedback() -> String? {
        return UserDefaults.standard.string(forKey: "Feedback")
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
