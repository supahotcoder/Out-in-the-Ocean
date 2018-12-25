//
//  Joystick.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class Joystick {
    
    private(set) var node : SKSpriteNode?
    private(set) var insideFrame : Bool
    
    var touch  = CGPoint(x: 0, y: 0)
    var turnAngle : CGFloat = 0

    let speed : CGFloat = 4
    let touchRadius : CGFloat = 100
    let maxVelocity : CGFloat = 100
    
    init() {
        let texture = SKTexture(imageNamed: "joystick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))
        node?.position = CGPoint(x: 0,y: 0)
        insideFrame = false
    }
    
    //kontrola kliknutí do joysticku
    func didTouchJoystick(location: CGPoint){
        insideFrame = (node?.frame.contains(location))!
    }
    
    //konec pohybu
    func stopMovement(){
        insideFrame = false
    }
    
    //konec pohybu
    func stealthMode(playerNode: SKSpriteNode){
        insideFrame = false
        var playerVel = playerNode.physicsBody?.velocity
        playerVel?.dx *= 0.5
        playerVel?.dy *= 0.5
        playerNode.physicsBody?.velocity = playerVel!
    }

    
    // regulátor maximální rychlosti
    func maxVelocityCheck(node : SKSpriteNode){
        var velocity = (node.physicsBody?.velocity)!
        if abs(velocity.dx) > maxVelocity {
            if velocity.dx < 0{
                velocity = CGVector(dx: -maxVelocity, dy: velocity.dy)
            }
            else{
               velocity = CGVector(dx: maxVelocity, dy: velocity.dy)
            }
        }
        if abs(velocity.dy) > maxVelocity {
            if velocity.dy < 0{
                velocity = CGVector(dx: velocity.dx, dy: -maxVelocity)
            }
            else {
                velocity = CGVector(dx: velocity.dx, dy: maxVelocity)
                
            }
        }
        node.physicsBody?.velocity = velocity
    }
    
    func movement(moveWith node: SKSpriteNode) {
        if insideFrame{
            let movement = CGVector(dx: (touch.x * speed)/100, dy:  (touch.y * speed)/100)
            let rotation = SKAction.rotate(toAngle: (turnAngle + CGFloat(90 * (Double.pi/50)) + 0.7), duration: 0.1, shortestUnitArc: true)
            node.run(rotation)
            node.physicsBody?.applyImpulse(movement)
            //maxspeed check
            maxVelocityCheck(node: node)
        }
    }
    
}
