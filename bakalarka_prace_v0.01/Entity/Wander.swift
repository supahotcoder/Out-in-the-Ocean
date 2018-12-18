//
//  Wander.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 17/12/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Wander: GKEntity {
    
    let entityManager : EntityManager
    
    //FIXME: MISSING INTERACTION
    init(interaction: Bool, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        
        let texture = SKTexture(imageNamed: "wander")
        
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: CGSize(width: 120, height: 120))
        addComponent(spriteComp)
        
        //TODO: - Avoid || Not
        let avoidComp = AvoidCollisionComponent()
        addComponent(avoidComp)
        
        let moveComp = MoveComponent(maxSpeed: 40, maxAcceleration: 20, effectiveRadius: Float(spriteComp.node.size.width), entityManager: self.entityManager)
        addComponent(moveComp)
        
        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.wander.rawValue, dynamicObject: true, canRotate: true, pathBody: wanderBody(node: spriteComp.node), mass: 5)
        addComponent(contactComp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
