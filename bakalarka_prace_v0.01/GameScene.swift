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
        
        // BACKGROUND BOUNDARY
        background = childNode(withName: "pozadi") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!) //
        edgePhysicsBody.categoryBitMask = bitmasks.frame.rawValue
        edgePhysicsBody.contactTestBitMask = bitmasks.player.rawValue
        edgePhysicsBody.collisionBitMask = bitmasks.player.rawValue
        self.physicsBody = edgePhysicsBody
        
        // CAMERA SETUP
        let cameraNode = SKCameraNode()
        cameraNode.addChild(joystickFrame!)
        self.camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(cameraNode)
 
        // ENTITY SETUP
        entityManager = EntityManager(scene: self.scene!)

        // ACTIVE BACKGROUND SETUP
        let activeBack = ActiveBackground(imageName: "player_test")
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
           acNode.size = CGSize(width: 100 , height: 100)
            acNode.position = CGPoint(x: -250, y: 0)
            // nastavení Z pozice
            acNode.zPosition = 3
        }
        entityManager.add(entity: activeBack)
        
        //PLAYER SETUP
        let player = Player(imageName: "player_test")
        if let pNode = player.component(ofType: SpriteComponent.self)?.node {
            pNode.position =  CGPoint(x: (background?.frame.minX)! + 10,y: (self.scene?.position.y)!)
            pNode.size = CGSize(width: 60 , height: 60)
            playerNode = pNode
             // nastavení Z pozice
            playerNode?.zPosition = 3
        }
        entityManager.add(entity: player)
    }

    // MARK: - TOUCHES
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if let joystickNode = joystickNode {
                let loc = touch.location(in: joystickNode)
                joystick.didTouchJoystick(location: loc)
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
        //odražení od objektu
        player.applyForce(CGVector(dx: -player.velocity.dx, dy: -player.velocity.dy))
    }
    
        //MARK: - UPDATE
    override func update(_ currentTime: TimeInterval) {
        joystick.movement(moveWith: playerNode!)
        camera?.cameraMovementWithin(Within: background!, CameraFocusOn: playerNode! , durationOfCameraMovement: 0.3)
    }
}
