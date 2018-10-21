//
//  ActiveBackground.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 11/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class ActiveBackground: GKEntity {
    
     init(imageName: String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: texture.size())
        let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.activeBackground.rawValue, dynamicObject: true, canRotate: false)
        
        addComponent(contactComponent)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
