//
//  GameScene.swift
//
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

class GameSceneClass: SKScene, SKPhysicsContactDelegate {


    // MARK: - GLOBAL VARS
    weak var playerNode: SKSpriteNode?
    var joystick: Joystick!
    weak var joystickNode: SKSpriteNode?
    var entityManager: EntityManager!
    // static kvuli tomu at nemame vice instantci audioPrehravacu
    private static var backgroundMusicPlayer: AVAudioPlayer? = nil
    
    private var openedMenuDate: Date = Date()
    var totalTimeInMenu: Double = 0
    
    var background: SKSpriteNode?
    var goals: [ActiveBackground] = [ActiveBackground]()

    var goalText = SKLabelNode()
    var playerText = SKLabelNode()
    //#error("When story text is about to be selected: pause, focus etc.")
    var storyText = SKLabelNode()
    var warningText = SKLabelNode()

    var playerSpawnPosition: CGPoint? = nil

    var lastUpdateTimeInterval: TimeInterval = 0
    var cameraFocusActions: Queue<SKAction> = Queue<SKAction>()
    var storyTellingActions: Queue<(canLaunch:() -> Bool,node: SKNode,action:[SKAction])> = Queue<(canLaunch:() -> Bool ,node: SKNode,action:[SKAction])>()
    var currStoryActions: (canLaunch:() -> Bool,node: SKNode,action:[SKAction])? = nil
    
    static var haveDied = false

    var pauseButton: SKSpriteNode?
    var helpButton: SKSpriteNode?
    var resumeButton: SKSpriteNode?
    var restartButton: SKSpriteNode?
    var settingsButton: SKSpriteNode?
    var menuButton: SKSpriteNode?
    var pauseBackground: SKSpriteNode?
    
    var helpBox: HelpBox?
    var settingsBox: SettingsBox?
    var changingLevel = false


    required init?(coder aDecoder: NSCoder) {
        //RESET MUSIC
        GameSceneClass.backgroundMusicPlayer?.pause()
        print(GameSceneClass.haveDied)
        if !GameSceneClass.haveDied {
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
        entityManager = EntityManager(scene: self.scene! as! GameSceneClass)

        //PLAYER SETUP
        if playerSpawnPosition == nil {
            playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 10, y: (self.scene?.position.y)!)
        }
        playerNode = entityManager.loadPlayer(position: playerSpawnPosition!)

        //CAMERA SETUP
        let cameraNode = SKCameraNode()
        cameraNode.addChild(joystickNode!)
        self.camera = cameraNode
        addChild(cameraNode)
        camera!.movement(within: background!, cameraFocusOn: playerNode!, durationOfMovement: 0)
        camera?.scaleFor(device: device)

        //DISPLAY TEXT SETUP
        goalText.fontName = "Futura-CondensedExtraBold"
        goalText.numberOfLines = 3
        
        playerText.fontName = "Futura-CondensedExtraBold"
        playerText.numberOfLines = 2

        warningText.fontName = "Futura-CondensedExtraBold"

        storyText.fontName = "Futura-CondensedExtraBold"
        storyText.numberOfLines = 5

        //Pause-menu setup
        pauseButton = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), color: .white, size: buttonSize.pauseButton.toCGSize)
        pauseButton!.position = CGPoint(x: screen.width / 2 - (pauseButton?.size.width)! / 2, y: screen.height / 2 - (pauseButton?.size.height)! / 2)
        pauseButton!.zPosition = 10
        pauseButton?.name = "pauseButton"
        let lbl = SKLabelNode(text: "| |")
        lbl.position = CGPoint(x: 0, y: -(buttonSize.pauseButton.toCGSize.height / 9))
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
        // LOAD SETTINGS
        let isDynamicJoystick = UserDefaults.standard.bool(forKey: "joystickSettings")
        joystick.isDynamic = isDynamicJoystick
        // SETUP SETTINGS
        settingsBox = SettingsBox(joystick: joystick)
    }

    //MARK: - MOVEMENT FUNCTIONS

    func moveInDirection(direction: CGPoint, pulseForce: CGVector, with: SKSpriteNode) {
        with.physicsBody?.applyImpulse(pulseForce, at: direction)
    }

    func changeLevelGravity(gravity: CGVector) {
        self.physicsWorld.gravity = gravity
    }

    func move(with: SKSpriteNode, towards: SKSpriteNode, pulseForce: CGVector) {
        with.physicsBody?.applyImpulse(pulseForce, at: towards.position)
    }

    //MARK: - DISPLAY TEXT
    
    func runInSequence(node: SKNode,actions:[SKAction], index:Int = 0) {
        if index < actions.count {
            let action = actions[index]
            node.run(action) {
                // Avoid retain cycle
                [weak self] in
                self?.runInSequence(node: node,actions: actions, index: index+1)
            }
        }
    }

    func updatePlayerThoughtText(with text: String, displayIn: Double = 0.1, fadeOut: Double = 1.5) {
        var textNode = playerText.copy() as! SKLabelNode
        textNode.numberOfLines = 3
        textNode.fontColor = UIColor.lightGray
        updateText(with: text, label: &textNode)
        let actions = prepareTextActions(displayIn: displayIn,fadeIn: 0.1, fadeOut: fadeOut, label: textNode, around: playerNode!, alignment: .leftBottom)
        //        pozadi textu pro lepsi citelnost
        let textBackground = SKSpriteNode(color: UIColor.black, size: CGSize(width: CGFloat(textNode.frame.size.width), height:CGFloat(textNode.frame.size.height)))
        textBackground.position = CGPoint(x: 0, y: textBackground.size.height / 2)
        textBackground.zPosition = -1
        textNode.addChild(textBackground)
        runInSequence(node: textNode, actions: actions)
    }
    
    func updateGoalText(with text: String, around: SKNode, displayIn: Double = 1, fadeOut: Double = 2) {
        var textNode = goalText.copy() as! SKLabelNode
        textNode.numberOfLines = 3
        textNode.color = UIColor.lightGray
        updateText(with: text, label: &textNode)
        let actions = prepareTextActions(displayIn: displayIn,fadeIn: 0.1, fadeOut: fadeOut, label: textNode, around: playerNode!, alignment: .rightTop)
        //        pozadi textu pro lepsi citelnost
        let textBackground = SKSpriteNode(color: UIColor.darkGray, size: CGSize(width: CGFloat(textNode.frame.size.width), height:CGFloat(textNode.frame.size.height)))
        textBackground.position = CGPoint(x: 0, y: textBackground.size.height / 2)
        textBackground.zPosition = -1
        textNode.addChild(textBackground)
        runInSequence(node: textNode, actions: actions)
    }

    @discardableResult
    func updateFeedbackText(with text: String, displayIn: Double = 0, around: SKSpriteNode? = nil) -> SKLabelNode{
        var textNode = goalText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        let actions = prepareTextActions(displayIn: displayIn, fadeOut: 0.5, label: textNode, around: around ?? playerNode!, alignment: .onEntity)
        let textBackground = SKSpriteNode(color: UIColor.darkGray, size: CGSize(width: CGFloat(textNode.frame.size.width), height:CGFloat(textNode.frame.size.height)))
        textBackground.position = CGPoint(x: 0, y: textBackground.size.height / 2)
        textBackground.zPosition = -1
        textNode.addChild(textBackground)
        runInSequence(node: textNode, actions: actions)
        return textNode
    }

    @discardableResult
    func updateStoryText(with text: String, around: SKNode, displayIn: Double = 0, fadeIn fadeIn_: Double? = nil, fadeOut: Double = 1, forDuration: TimeInterval? = nil, closure: () -> Void = {return}) -> SKLabelNode {
        var textNode = storyText.copy() as! SKLabelNode
        textNode.numberOfLines = 5
        updateText(with: text, label: &textNode)
        let fadeIn = fadeIn_  ?? 0.1
        let actions = prepareTextActions(displayIn: displayIn, fadeIn: fadeIn, fadeOut: fadeOut, label: textNode, around: around, alignment: .rightBottom, forDuration: forDuration)
        var actionsTotalSec = displayIn + (forDuration ?? TimeInterval(text.count) / TEXT_SPEED) + fadeIn + fadeOut - (CAMERA_MOVEMENT_TIME)// kvuli casu trvani presunu kamery
        if let duration = forDuration{
            let durationExtraTime = (duration * (textSpeeds(rawValue: TEXT_SPEED)?.getForDurationModifier() ?? 1)) - duration
            actionsTotalSec += durationExtraTime
        }
        if displayIn == 0{
            storyTellingActions.enqueue((canLaunch: {true},node: textNode, action: actions))
            storyTellingActions.enqueue((canLaunch: {true},node: around, action: [SKAction.wait(forDuration: 0)]))
        }else{
            let dateNow = Date()
            storyTellingActions.enqueue((canLaunch: {-dateNow.timeIntervalSinceNow > actionsTotalSec},node: textNode, action: actions))
            storyTellingActions.enqueue((canLaunch: {true},node: around, action: [SKAction.wait(forDuration: 0)]))
        }
        focusOnNode(node: around, timeToFocusOn: actionsTotalSec)
        disableMovement()
//        pozadi textu pro lepsi citelnost
        let textBackground = SKSpriteNode(color: UIColor.darkGray, size: CGSize(width: CGFloat(textNode.frame.size.width), height:CGFloat(textNode.frame.size.height)))
        textBackground.position = CGPoint(x: 0, y: textBackground.size.height / 2)
        textBackground.zPosition = -1
        textNode.addChild(textBackground)
        return textNode
    }

    func updateWarningText(with text: String, around: SKNode, displayIn: Double = 0.5, fadeOut: Double = 1, forDuration: TimeInterval? = nil) -> [SKAction] {
        var textNode = warningText.copy() as! SKLabelNode
        updateText(with: text, label: &textNode)
        return prepareTextActions(displayIn: displayIn, fadeOut: fadeOut, label: textNode, around: around, alignment: .leftBottom, forDuration: forDuration)
    }

    func focusOnNode(node: SKNode, timeToFocusOn: TimeInterval) {
        if let cam = camera{
            let action = cam.generateMovementAction(within: background!, cameraFocusOn: node, durationOfMovement: CAMERA_MOVEMENT_TIME, waitTime: timeToFocusOn)
            cameraFocusActions.enqueue(action)
//            přidání akce "bez" účinku do fronty optimalizujeme v metodě update kontrolu zda akce běží pro uzel
//            při každém zavolání metody update se nemusí kontrolovat zda běží nějaká příběhová, jelikož prázdná akce zajistí, že fronta není prázdná a hráči nedovolí ovládat postavu
            cameraFocusActions.enqueue(SKAction.wait(forDuration: 0))
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
        for touch in touches {
            if (!changingLevel) {
                let t = touches.first?.location(in: camera!)
                if helpBox?.active ?? false{
                    helpBox?.didCloseHelp(touches: touches, touchedIn: camera!)
                }else if settingsBox?.active ?? false{
                    settingsBox?.didTouched(touches: touches, touchedIn: camera!)
                } else if !(pauseButton?.isHidden)!, pauseButton!.frame.contains(t!) {
                    pauseGame()
                    return
                } else if !(resumeButton?.isHidden)!, (resumeButton?.frame.contains(t!))! {
                    resumeGame()
//                    vyskoceni z cyklu at se neaktivuje joystick
                    return
                } else if !(helpButton?.isHidden)!, (helpButton?.frame.contains(t!))! {
                    showHelp()
                } else if !(settingsButton?.isHidden)!, (settingsButton?.frame.contains(t!))! {
                    showSettings()
                } else if !(restartButton?.isHidden)!, (restartButton?.frame.contains(t!))! {
                    #warning("SCENE MUST HAVE A SAME NAME AS IT'S CLASS")
                    if let scene = SKScene(fileNamed: (self.scene?.name)!) {
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(scene)
                    }
                } else if !(menuButton?.isHidden)!, (menuButton?.frame.contains(t!))! {
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
                //stealth mode
                joystick.didTouchJoystick(location: t!)
                if touch.tapCount == 2 && joystick.insideFrame {
                    joystick.stealthMode(playerNode: playerNode!)
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: joystickNode!)
            let length = position.length()
            let angle = atan2(position.y, position.x)
            joystick.turnAngle = angle

            if joystick.thumbstick.radius > length, joystick.insideFrame {
                joystick.touch = position
            } else if joystick.insideFrame {
                let pos = CGPoint(x: cos(angle) * joystick.touchRadius, y: sin(angle) * joystick.touchRadius)
                joystick.touch = pos
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.stopMovement()
    }

    func disableMovement() {
        if joystickNode?.parent != nil{
            joystickNode?.isPaused = true
            joystickNode?.isHidden = true
            joystickNode?.removeFromParent()
            joystick.stopMovement()
        }
    }

    func enableMovement() {
        if !(camera?.contains(joystickNode!) ?? true) {
            joystickNode?.isPaused = false
            joystickNode?.isHidden = false
            joystick.isHidden = false
            joystick.enableJoystick()
            camera?.addChild(joystickNode!)
        }
    }

    //MARK: - SOUNDS

    fileprivate func loadAndPlayMusic(_ fileName: String, _ ex: String) throws {
//        hudbu podle nazvu a zacne ji prehravat
        try GameSceneClass.backgroundMusicPlayer = AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: ex)!)
        GameSceneClass.backgroundMusicPlayer!.numberOfLoops = -1
        GameSceneClass.backgroundMusicPlayer!.prepareToPlay()
        GameSceneClass.backgroundMusicPlayer!.play()
    }
    
    func backgroundMusic(fileName: String, extension ex: String) {
        do {
//            potencionalni oprava pokud mame iOS 16 a zarizeni nastavene v tichem rezime, tak diky teto uprave muzeme prehravat zvuk
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
            
        }
        do {
            if GameSceneClass.backgroundMusicPlayer == nil {
                try loadAndPlayMusic(fileName, ex)
            } else {
                if let url = GameSceneClass.backgroundMusicPlayer!.url{
                    if url.lastPathComponent.contains(fileName){
                        GameSceneClass.backgroundMusicPlayer!.prepareToPlay()
                        GameSceneClass.backgroundMusicPlayer!.play()
                    }else{
                        try loadAndPlayMusic(fileName, ex)
                    }
                }else{
                    try loadAndPlayMusic(fileName, ex)
                }
            }
        } catch {
            print("AVAudioPlayer crashed")
        }
    }

    func stopAndRemoveMusic() {
        if GameSceneClass.backgroundMusicPlayer != nil {
            GameSceneClass.backgroundMusicPlayer?.stop()
            GameSceneClass.backgroundMusicPlayer = nil
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
        if let cam = camera{
            if cameraFocusActions.isEmpty{
                cam.movement(within: background!, cameraFocusOn: playerNode!, durationOfMovement: CAMERA_MOVEMENT_TIME)
            }
            else{
                if !cam.hasActions() && !cameraFocusActions.isEmpty{
                    if let focusActions = cameraFocusActions.dequeue(){
                        hidePauseButton()
                        disableMovement()
                        cam.run(focusActions)
                    }
                    if cameraFocusActions.isEmpty{
                        showPauseButton()
                        enableMovement()
                    }
                }
            }
        }
        
        if !storyTellingActions.isEmpty{
            if !(currStoryActions?.node.hasActions() ?? false){
                currStoryActions = storyTellingActions.front!
                if currStoryActions!.canLaunch(){
                    storyTellingActions.dequeue()
                    pauseGKEntities()
                    runInSequence(node: currStoryActions!.node, actions: currStoryActions!.action)
                }else{
                    restartGKEntities()
                }
                if storyTellingActions.isEmpty{
                    restartGKEntities()
                }
            }
        }
        entityManager.update(deltaTime)

    }
    
    func waitAndRun<T>(delay: Double, function: @escaping () -> T) {
        let wrapedFunc: () -> Void = { () in
            function()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: wrapedFunc)
    }

    private func pauseGameSetup() {
        pauseBackground = SKSpriteNode(color: .darkGray, size: UIScreen.main.bounds.size)
        pauseBackground?.alpha = 0.5

        let buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: buttonSize.menuButton.toCGSize)
        let labelBlueprint = SKLabelNode(text: "SampleTxt")
        labelBlueprint.position = CGPoint(x: 0, y: 0)
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        labelBlueprint.fontSize = buttonBlueprint.size.height / 4
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)
        
        helpButton = buttonBlueprint.copy() as? SKSpriteNode
        let helpButtonSize = buttonSize.pauseButton.toCGSize
        helpButton?.size = helpButtonSize
        helpButton?.position = CGPoint(x: (UIScreen.main.bounds.width / 2) - (helpButton?.size.width)! / 2, y: (UIScreen.main.bounds.height / 2) - (helpButton?.size.height)! / 2)
        helpButton?.zPosition = 10
        labelBlueprint.position = CGPoint(x: 0, y: -(helpButtonSize.height / 9))
        labelBlueprint.text = "Help"
        labelBlueprint.fontSize = helpButtonSize.height / 8
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: helpButtonSize)
        helpButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        helpButton?.isHidden = true
        
//        RESTARTOVANI SKALOVANI TEXTU PRO VELKE MENU TLACITKA
        labelBlueprint.position = CGPoint(x: 0, y: 0)
        labelBlueprint.text = "SampleTxt"
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)
        
        resumeButton = buttonBlueprint.copy() as? SKSpriteNode
        resumeButton?.position = CGPoint(x: 0, y: (UIScreen.main.bounds.height / 3))
        resumeButton?.zPosition = 10
        labelBlueprint.text = "Resume"
        resumeButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        resumeButton?.isHidden = true

        restartButton = buttonBlueprint.copy() as? SKSpriteNode
        restartButton?.position = CGPoint(x: 0, y: (UIScreen.main.bounds.height / 3) / 3)
        labelBlueprint.text = "Restart"
        restartButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        restartButton?.zPosition = 10
        restartButton?.isHidden = true

        settingsButton = buttonBlueprint.copy() as? SKSpriteNode
        settingsButton?.position = CGPoint(x: 0, y: -(UIScreen.main.bounds.height / 3) / 3)
        labelBlueprint.text = "Settings"
        settingsButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        settingsButton?.zPosition = 10
        settingsButton?.isHidden = true

        menuButton = buttonBlueprint.copy() as? SKSpriteNode
        menuButton?.position = CGPoint(x: 0, y: -UIScreen.main.bounds.height / 3)
        labelBlueprint.text = "Menu"
        menuButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        menuButton?.zPosition = 10
        menuButton?.isHidden = true
    }

    func pauseGKEntities() {
        let gkDriven = entityManager.entitiesWithMoveComponent()
        gkDriven.forEach { (x) in
            x.delegate = nil
        }
    }
    
    func pauseGame() {
        openedMenuDate = Date()
        GameSceneClass.backgroundMusicPlayer?.pause();
        helpButton?.isHidden = false
        restartButton?.isHidden = false
        resumeButton?.isHidden = false
        settingsButton?.isHidden = false
        menuButton?.isHidden = false
        pauseGameState()
        camera?.addChild(pauseBackground!)
        camera?.addChild(helpButton!)
        camera?.addChild(resumeButton!)
        camera?.addChild(restartButton!)
        camera?.addChild(settingsButton!)
        camera?.addChild(menuButton!)
    }

    func pauseGameState() {
        disableMovement()
        hidePauseButton()
        //pause for gameplaykit driven entities
        pauseGKEntities()
        scene?.isPaused = true
    }

    func restartGKEntities() {
        let gkDriven = entityManager.entitiesWithMoveComponent()
        gkDriven.forEach { (x) in
            let resetMovement = SKAction.run {
                x.resetAgentDelegate()
            }
            self.run(resetMovement)
        }
    }
    
    func resumeGame() {
        totalTimeInMenu += abs(openedMenuDate.timeIntervalSinceNow)
        GameSceneClass.backgroundMusicPlayer?.play()
        restartButton?.isHidden = true
        resumeButton?.isHidden = true
        helpButton?.isHidden = true
        settingsButton?.isHidden = true
        menuButton?.isHidden = true
        resumeGameState()
        if !cameraFocusActions.isEmpty{
            disableMovement()
            hidePauseButton()
        }
        helpButton?.removeFromParent()
        resumeButton?.removeFromParent()
        restartButton?.removeFromParent()
        settingsButton?.removeFromParent()
        menuButton?.removeFromParent()
        pauseBackground?.removeFromParent()
    }


    func resumeGameState() {
        showPauseButton()
        restartGKEntities()
        scene?.isPaused = false
        enableMovement()
    }

    private func hidePauseButton() {
        pauseButton?.isHidden = true
        pauseButton?.removeFromParent()
    }

    private func showPauseButton() {
        pauseButton?.isHidden = false
        pauseButton?.alpha = 1
        if ((camera?.childNode(withName: "pauseButton")) == nil){
            camera?.addChild(pauseButton!)
        }
    }

    func showHelp(){
        helpBox?.showHelp(parentNode: camera!)
    }

    func showSettings() {
        settingsBox?.showSettings(parentNode: camera!)
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
        resumeGame()
        pauseGame()
        view?.isPaused = !(view?.isPaused)!
    }

    @objc func applicationDidBecomeActive() {
        view?.isPaused = !(view?.isPaused)!
        resumeGame()
        pauseGame()
    }

}
