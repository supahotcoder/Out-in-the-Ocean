//
//  Player.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    // imageName -> protože se bude Player textura měnit počas hry
     init(imageName : String) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: texture.size())
        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.player.rawValue, dynamicObject: true, canRotate: true)
        
        addComponent(contactComp)
        addComponent(spriteComp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
