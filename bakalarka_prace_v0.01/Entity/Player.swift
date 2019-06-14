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
    init(imageName : String, entityManager: EntityManager) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: CGSize(width: 60, height: 60))
        addComponent(spriteComp)
        //add spriteComponent první protože by se potom v contactu nedotázalo na spriteComponentu
        
        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.player.rawValue, dynamicObject: true, canRotate: true)
        addComponent(contactComp)
        
        let moveComp = MoveComponent(maxSpeed: 0, maxAcceleration: 0, effectiveRadius: Float(spriteComp.node.size.width / 2 ), entityManager: entityManager)
        addComponent(moveComp)
        
        addComponent(PlayerComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
