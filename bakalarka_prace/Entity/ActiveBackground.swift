//
//  ActiveBackground.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class ActiveBackground: GKEntity {
    
    init(imageName: String, entityManager: EntityManager) {
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageName))
        addComponent(spriteComponent)
        
        //let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.activeBackground.rawValue, dynamicObject: false, canRotate: false)
        
        // Contact bude jenom na střední kruh
        let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.activeBackground.rawValue, dynamicObject: false, canRotate: false, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageName, sprite: spriteComponent.node))
        addComponent(contactComponent)
        
        let moveComponent = MoveComponent(maxSpeed: 0, maxAcceleration: 0, effectiveRadius: Float(spriteComponent.node.size.width / 2), entityManager: entityManager)
        addComponent(moveComponent)
        
        addComponent(AvoidCollisionComponent())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
