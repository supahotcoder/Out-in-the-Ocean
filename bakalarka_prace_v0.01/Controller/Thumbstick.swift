//
//  Thumbstick.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 24/02/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Thumbstick{
    
    private(set) var node: SKSpriteNode
    
    let radius: CGFloat 
    
    init(image: String,screen: CGRect,device: UIUserInterfaceIdiom){
        var size : CGFloat = 1
        switch device {
        case .pad:
            size = 2
        case .phone:
            if (screen.width + screen.height) < 2000{
                size = 2.3
            }
        default:
            break
        }
        self.radius = (screen.width + screen.height) * 0.025 * size
        let texture = SKTexture(imageNamed: image)
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: radius, height: radius))
    }
    
    func moveTo(position: CGPoint) {
        node.position = position
    }
    
    func resetThumbstick() {
        let moveBack = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.1)
        node.run(moveBack)
    }
    
}
