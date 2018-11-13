//
//  JoystickFrame.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 15/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit

class JoystickFrame {
    
    let node : SKSpriteNode?
    
    private let touchRadius = CGFloat(100)
    
    init() {
        let texture = SKTexture(imageNamed: "transp")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))
        node?.position = CGPoint(x: -180,y: -90)
    }
}
