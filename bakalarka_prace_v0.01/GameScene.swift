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
    
    var previousTimeInterval = TimeInterval(0)
    
    var joystickFrame: SKNode?
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //nastavení fyziky
   
        joystick = Joystick()
        joystickNode = joystick.node
        joystickNode?.alpha = CGFloat(0.4)
        joystickFrame = JoystickFrame().node

        joystickFrame?.addChild(joystickNode!)
        self.addChild(joystickFrame!)

        entityManager = EntityManager(scene: self.scene!)

        //contact test
        let activeBack = ActiveBackground(imageName: "player_test")
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
           acNode.size = CGSize(width: 30 , height: 30)
            acNode.position = CGPoint(x: -250, y: 0)
        }
        entityManager.add(entity: activeBack)
        
        let player = Player(imageName: "player_test")
        if let pNode = player.component(ofType: SpriteComponent.self)?.node {
            pNode.position =  CGPoint(x: 250,y: 0)//self.scene?.position ?? CGPoint(x: 0, y: 0)
            pNode.size = CGSize(width: 60 , height: 60)
            playerNode = pNode
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
        joystick.touch = CGPoint(x: 0, y: 0)
        //resetování do půvvodní polohy (není pohyb)
        
        let xPos = Double(joystick.touch.x)
        let yPos = Double(joystick.touch.y)
        let movement = CGVector(dx: xPos * joystick.speed * 2 , dy:   yPos * joystick.speed * 2)
        let move = SKAction.move(by: movement, duration: 0.4)
        playerNode?.run(move)
        // pomalejší zastavení
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
        
    }
    
    
    //MARK: UPDATE
    override func update(_ currentTime: TimeInterval) {
        if joystick.insideFrame{
            let deltaTime = currentTime - previousTimeInterval
            previousTimeInterval = currentTime
            
            let xPos = Double(joystick.touch.x)
            let yPos = Double(joystick.touch.y)
            
            let movement = CGVector(dx: deltaTime * xPos * joystick.speed, dy:  deltaTime * yPos * joystick.speed)
            //print(movement)
            let rotation = SKAction.rotate(toAngle: (joystick.turnAngle + CGFloat(90 * (Double.pi/50)) + 0.2), duration: 0.1, shortestUnitArc: true)
            // + 0.2 protože na testovací textuře nejsou oči v rovině
            let move = SKAction.move(by: movement, duration: 0.1)
            let actionSeq = SKAction.sequence([rotation,move])
            playerNode?.run(actionSeq)
        }
       // print(playerNode?.position)
    }
}
