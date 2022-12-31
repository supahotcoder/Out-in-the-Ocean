//
//  Player.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    
    init(imageName : String, entityManager: EntityManager) {
        super.init()
        
        let texture = SKTexture(imageNamed: imageName)
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageName))
        addComponent(spriteComp)
        // pridani spriteComponent první protože by se potom v contactu nemelo jak dotazat na spriteComponentu

        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.player.rawValue, dynamicObject: true, canRotate: true, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageName, sprite: spriteComp.node))
        addComponent(contactComp)
        
        let moveComp = MoveComponent(maxSpeed: 0, maxAcceleration: 0, effectiveRadius: Float(spriteComp.node.size.width / 2 ), entityManager: entityManager)
        addComponent(moveComp)
        
        addComponent(PlayerComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
