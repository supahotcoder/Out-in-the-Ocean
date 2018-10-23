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

    let speed : Double = 4
    let touchRadius : CGFloat = 100
    let maxVelocity : CGFloat = 150
    
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
    
    // regulátor maximální rychlosti
    func maxVelocityCheck(velocity : CGVector) -> CGVector{
        if abs(velocity.dx) > maxVelocity && abs(velocity.dy) > maxVelocity {
            if velocity.dx < 0 && velocity.dy < 0{
                return CGVector(dx: -maxVelocity, dy: -maxVelocity)
            }
            else if velocity.dx < 0 {
                return CGVector(dx: -maxVelocity, dy: maxVelocity)
            }
            else if  velocity.dy < 0{
                return CGVector(dx: maxVelocity, dy: -maxVelocity)
            }
             return CGVector(dx: maxVelocity, dy: maxVelocity)
        }
        else if abs(velocity.dx) > maxVelocity {
            if velocity.dx < 0{
                return CGVector(dx: -maxVelocity, dy: velocity.dy)
            }
             return CGVector(dx: maxVelocity, dy: velocity.dy)
        }
        
        else if abs(velocity.dy) > maxVelocity {
            if velocity.dy < 0{
                return CGVector(dx: velocity.dx, dy: -maxVelocity)
            }
            return CGVector(dx: velocity.dx, dy: maxVelocity)
        }
        else{
            return velocity
            
        }
    }
    
}
