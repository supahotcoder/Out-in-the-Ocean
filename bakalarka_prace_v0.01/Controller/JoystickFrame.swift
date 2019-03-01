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
    
    private let touchRadius : CGFloat
    
    init(screen: CGRect,device: UIUserInterfaceIdiom) {
        var size : CGFloat = 1
        switch device {
        case .pad:
            size = 2
//        case .phone:
////            if (screen.width + screen.height) < 2000{
////                size = 2.3
////            }
        default:
            break
        }
        self.touchRadius = (screen.width + screen.height) * 0.05 * size
        let texture = SKTexture(imageNamed: "transp")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))
        // 1334 750
            node?.position = CGPoint(x: Double(screen.width) * -0.3, y: Double(screen.height) *  -0.3)
        //node?.position = CGPoint(x: -180,y: -90)
    }
}
