//
//  GameScene.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 19.09.18.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {
  
    // MARK: - GLOBAL VARS
    
    var playerNode : SKSpriteNode?
    var joystick : Joystick!
    var joystickNode :SKSpriteNode?
    var entityManager : EntityManager!
    
    var joystickFrame: SKNode?
    var background : SKSpriteNode?
    var activeBack : ActiveBackground!
    var goals : [ActiveBackground] = [ActiveBackground]()
    
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
        
        // CAMERA SETUP
        let cameraNode = SKCameraNode()
        cameraNode.addChild(joystickFrame!)
        self.camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(cameraNode)
        
        // ENTITY SETUP
        entityManager = EntityManager(scene: self.scene!)
        
        //PLAYER SETUP
        if playerSpawnPosition == nil {
            playerSpawnPosition = CGPoint(x: (background?.frame.minX)! + 10,y: (self.scene?.position.y)!)
        }

        playerNode = entityManager.loadPlayer(position: playerSpawnPosition!)
    }

    // MARK: - Double tap on joystick will instantly stop player and go to stealth mode

    
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
            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
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
    
    //MARK: - COLISION/CONTACT
    func didBegin(_ contact: SKPhysicsContact) {
        let player : SKPhysicsBody
        let otherNode : SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyA
            otherNode = contact.bodyB
        }
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyB
            otherNode = contact.bodyA
        }
        else {
            return
        }
        
//         ODSTRANĚNÍ PŘI KOLIZI
            if otherNode.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
                entityManager.remove(entity: activeBack)
                activeBack = nil

            }
        if otherNode.node?.physicsBody?.categoryBitMask == bitmasks.searcher.rawValue{
            gameOver()
        }
        
        //player.applyForce(CGVector(dx: -player.velocity.dx, dy: -player.velocity.dy))
    }
    
    func gameOver() {
        if let scene = SKScene(fileNamed: "GameScene") {
            self.removeAllActions()
            self.removeAllChildren()
            view!.presentScene(scene)
        }
    }
    
        //MARK: - UPDATE
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        joystick.movement(moveWith: playerNode!)
        camera?.cameraMovementWithin(Within: background!, CameraFocusOn: playerNode! , durationOfCameraMovement: 0.3)
        entityManager.update(deltaTime)
        
        if (activeBack == nil){
            activeBack = entityManager.loadActiveBackground()
        }
    }
}
