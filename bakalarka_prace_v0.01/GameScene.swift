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
  
    var playerNode : SKSpriteNode?
    var joystick : Joystick!
    var joystickNode :SKSpriteNode?
    var entityManager : EntityManager!
    
    var joystickFrame: SKNode?
    var backgr : SKSpriteNode?
    
    func cameraMovement() {
        // TODO: nějak k tomu přidat pozice kde se frame nachází at pri kazdém levelu nestartuju uprostřed
        var change = false
        let l : CGFloat = -(backgr?.frame.width)! / 2 + size.width / 2
        let r : CGFloat = (backgr?.frame.width)! / 2 - size.width / 2
        let b : CGFloat = -(backgr?.frame.height)! / 2 + size.height / 2
        let t : CGFloat = (backgr?.frame.height)! / 2 - size.height / 2

        var position : CGPoint = (playerNode?.position)!
        
        if (camera?.position.x)! < l && (playerNode?.position.x)! <= l {
            change = true
            position.x = l
        }
        else if (camera?.position.x)! > r && (playerNode?.position.x)! >= r {
            change = true
            position.x = r
        }
        if (camera?.position.y)! > t && (playerNode?.position.y)! >= t {
            change = true
            position.y = t
        }
        else if (camera?.position.y)! < b && (playerNode?.position.y)! <= b {
            change = true
            position.y = b
        }
        if !change {
            camera?.run(SKAction.move(to: (playerNode?.position)!, duration: 0.3))
        }
        else{
            camera?.run(SKAction.move(to: position, duration: 0.3))
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //nastavení fyziky
        joystick = Joystick()
        joystickNode = joystick.node
        joystickNode?.alpha = CGFloat(0.4)
        joystickFrame = JoystickFrame().node

        joystickFrame?.addChild(joystickNode!)
        joystickFrame?.zPosition = 5
        
        backgr = childNode(withName: "pozadi") as? SKSpriteNode
        
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (backgr?.frame)!) //
        edgePhysicsBody.categoryBitMask = bitmasks.frame.rawValue
        edgePhysicsBody.contactTestBitMask = bitmasks.player.rawValue
        edgePhysicsBody.collisionBitMask = bitmasks.player.rawValue
        self.physicsBody = edgePhysicsBody
        
        // CAMERA
        let cameraNode = SKCameraNode()
        addChild(cameraNode)
        self.camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        cameraNode.addChild(joystickFrame!)
        
        entityManager = EntityManager(scene: self.scene!)

        let activeBack = ActiveBackground(imageName: "player_test")
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
           acNode.size = CGSize(width: 100 , height: 100)
            acNode.position = CGPoint(x: -250, y: 0)
            // nastavení Z pozice
            acNode.zPosition = 3
        }
        entityManager.add(entity: activeBack)
        
        let player = Player(imageName: "player_test")
        if let pNode = player.component(ofType: SpriteComponent.self)?.node {
            pNode.position =  CGPoint(x: 250,y: 0)//self.scene?.position ?? CGPoint(x: 0, y: 0)
            pNode.size = CGSize(width: 60 , height: 60)
            playerNode = pNode
             // nastavení Z pozice
            playerNode?.zPosition = 3
        }
        entityManager.add(entity: player)
    }

    // MARK: TOUCHES
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
            } else {
                joystick.touch  = CGPoint(x: cos(angle) * joystick.touchRadius, y: sin(angle) * joystick.touchRadius)
                }
            }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        joystick.stopMovement()
        joystick.touch = CGPoint(x: 0, y: 0)
    }
    
    //MARK: COLISION/CONTACT
    
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
            print("Not a player contact")
            return
        }
        //odražení od objektu
        player.applyForce(CGVector(dx: -player.velocity.dx, dy: -player.velocity.dy))
    }
    
        //MARK: UPDATE
    override func update(_ currentTime: TimeInterval) {
        if joystick.insideFrame{
            let xPos = Double(joystick.touch.x)
            let yPos = Double(joystick.touch.y)

            let movement = CGVector(dx: (xPos * joystick.speed)/100, dy:  (yPos * joystick.speed)/100)
            let rotation = SKAction.rotate(toAngle: (joystick.turnAngle + CGFloat(90 * (Double.pi/50)) + 0.7), duration: 0.1, shortestUnitArc: true)
            
            playerNode?.run(rotation)
            playerNode?.physicsBody?.applyImpulse(movement)
            //maxspeed check
            playerNode?.physicsBody?.velocity = joystick.maxVelocityCheck(velocity: (playerNode?.physicsBody?.velocity)!)
        }
        cameraMovement()
    }
}
