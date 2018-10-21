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
    let touchRadius = CGFloat(100)
    
    init() {
        let texture = SKTexture(imageNamed: "joystick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))
        node?.position = CGPoint(x: 0,y: 0)
        insideFrame = false
    }
    
    func didTouchJoystick(location: CGPoint){
        insideFrame = (node?.frame.contains(location))!
    }
    
}
