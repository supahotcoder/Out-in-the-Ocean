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
    
    private let maxVelocity : CGFloat = 100
    private let speed : CGFloat = 4
    
    var touch : CGPoint = CGPoint(x: 0, y: 0){
        // až při nastavování místa doteku v joysticku se počítá přesný pohyb páčky
        // hlavní důvod tohohle je přehlednost v GameScene
        willSet (position){
            if  thumbstick.radius < position.length(){
                let startPosition = CGPoint(x: (position.x / touchRadius) , y: (position.y / touchRadius))
                let thumb = CGPoint(x: startPosition.x * thumbstick.radius, y: startPosition.y * thumbstick.radius)
                thumbstick.moveTo(position: thumb)
            }
            else{
                thumbstick.moveTo(position: position)
            }
        }
    }
    
    let touchRadius : CGFloat
    var turnAngle : CGFloat = 0
    
    let thumbstick : Thumbstick
    
    init(screen: CGRect,adjustment: CGFloat) {
        self.touchRadius = (screen.width + screen.height) * 0.05 * adjustment
		
        let texture = SKTexture(imageNamed: "joystick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))
        node?.position = CGPoint(x: Double(screen.width) * -0.3, y: Double(screen.height) *  -0.3)
        insideFrame = false
        
        //inicializace páčky v joysticku
        thumbstick = Thumbstick(screen: screen, adjustment: adjustment)
    }
    
    //kontrola kliknutí do joysticku
    func didTouchJoystick(location: CGPoint){
        insideFrame = (node?.frame.contains(location))!
    }
    
    //konec pohybu
    func stopMovement(){
        insideFrame = false
        touch = CGPoint(x: 0, y: 0)
    }
    
    //zpomalení
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
    
    //pohyb s hráčem
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
