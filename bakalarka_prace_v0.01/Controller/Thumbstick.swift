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
    
    init(screen: CGRect , adjustment: CGFloat){
        self.radius = (screen.width + screen.height) * 0.025 * adjustment
        let texture = SKTexture(imageNamed: "thumbstick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: radius, height: radius))
    }
    
    //pohyb páčky joysticku
    func moveTo(position: CGPoint) {
        node.position = position
    }
    
    //uvedení páčky do středu joysticku
    func resetThumbstick() {
        let moveBack = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.1)
        node.run(moveBack)
    }
}
