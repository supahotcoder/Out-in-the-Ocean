//
//  Searcher.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Searcher: GKEntity {
    
    private let entityManager : EntityManager
    
    init(imageName: String, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: CGSize(width: 150, height: 150))
        addComponent(spriteComponent)

        let moveComponent = MoveComponent(maxSpeed: 50, maxAcceleration: 10, effectiveRadius: Float(spriteComponent.node.size.width), entityManager: self.entityManager)
        addComponent(moveComponent)
        
        let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.searcher.rawValue, dynamicObject: true, canRotate: true)
        addComponent(contactComponent)
        
        let enemyComponent = EnemyComponent()
        addComponent(enemyComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
