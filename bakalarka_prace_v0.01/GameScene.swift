//
//  GameScene.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 19.09.18.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneProtocol {
    func gameOver()
    func didBegin(_ contact: SKPhysicsContact)
}

typealias GameScene = GameSceneClass & GameSceneProtocol

class GameSceneClass: SKScene , SKPhysicsContactDelegate {
  
    // MARK: - GLOBAL VARS
    weak var playerNode : SKSpriteNode?
    private var joystick : Joystick!
    private weak var joystickNode :SKSpriteNode?
    var entityManager : EntityManager!
    
    var joystickFrame: SKNode?
    weak var background : SKSpriteNode?
    weak var activeBack : ActiveBackground!
    var goals : [ActiveBackground] = [ActiveBackground]()
    
    var goalText = SKLabelNode()
    var storyText = SKLabelNode()
    var warningText = SKLabelNode()
    
    var playerSpawnPosition: CGPoint? = nil
    
    var lastUpdateTimeInterval: TimeInterval = 0
    
    // MARK: - DIDMOVE
    override func didMove(to view: SKView) {
        
        //nastavení fyziky
        physicsWorld.contactDelegate = self

        //JOYSTICK SETUP
        joystick = Joystick()
        joystickNode = joystick.node
        joystickNode?.alpha = CGFloat(0.4)
        joystickFrame = JoystickFrame().node
        joystickFrame?.addChild(joystickNode!)
        joystickFrame?.zPosition = 5
        
        
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
        camera!.movementWithin(Within: background!, CameraFocusOn: playerNode! , durationOfMovement: 0)
        
        //DISPLAY TEXT SETUP
        goalText.fontName = "Futura-CondensedExtraBold"
        goalText.numberOfLines = 3
        
        warningText.fontName = "Futura-CondensedExtraBold"
        
        storyText.fontName = "Futura-CondensedExtraBold"
        storyText.numberOfLines = 5
    }

    //MARK: - DISPLAY TEXT
    func updateGoalText(with text: String, around: SKNode) {
        addChild(goalText)
        updateText(with: text, label: &goalText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: &goalText)
    }
    
    func updateStoryText(with text: String, around: SKNode) {
        addChild(storyText)
        updateText(with: text, label: &storyText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: &goalText)
    }
    
    func updateWarningText(with text: String, around: SKNode) {
        addChild(warningText)
        updateText(with: text, label: &warningText, around: around, alligment: .rightTop)
        displayText(displayIn: 1, fadeOut: 2, label: &goalText)
    }
    
    
    private func displayText(displayIn: TimeInterval,fadeOut: TimeInterval, label: inout SKLabelNode) {
        label.run(SKAction.sequence([SKAction.wait(forDuration: displayIn),SKAction.fadeIn(withDuration: displayIn / 2),
                                     SKAction.wait(forDuration: TimeInterval((label.text?.count)! / 5)),SKAction.fadeOut(withDuration: fadeOut), SKAction.removeFromParent()]))
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
            if joystick.touchRadius > length {
                joystick.touch = position
            }
            else {
                joystick.touch  = CGPoint(x: cos(angle) * joystick.touchRadius, y: sin(angle) * joystick.touchRadius)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.stopMovement()
        joystick.touch = CGPoint(x: 0, y: 0)
    }
    
    // implementace bude nutná u každého levelu solo
    //MARK: - GameOver, každý lvl handle sám
    
    //MARK: - UPDATE
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        joystick.movement(moveWith: playerNode!)
        camera?.movementWithin(Within: background!, CameraFocusOn: playerNode! , durationOfMovement: 0.3)
        entityManager.update(deltaTime)
        
        if (activeBack == nil){
            activeBack = entityManager.loadActiveBackground()
        }
    }
}
