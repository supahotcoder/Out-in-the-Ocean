//
//  Thumbstick.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Thumbstick{
    
    private(set) var node: SKSpriteNode
    
    let radius: CGFloat
    
    init(screen: CGRect , adjustment: CGFloat){
        self.radius = (screen.width + screen.height) * 0.025 * adjustment
        let texture = SKTexture(imageNamed: "thumbstick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: radius, height: radius))
    }
    
    //pohyb páčky joysticku
    func moveTo(position: CGPoint) {
        node.position = position
    }
}
