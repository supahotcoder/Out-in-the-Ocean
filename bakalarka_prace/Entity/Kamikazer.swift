//
// Created by Janko on 29.12.2022.
// Copyright (c) 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class Kamikazer: GKEntity {

    private let entityManager: EntityManager
    private var kamikazeComp: KamikazeComponent?

    init(imageName: String, entityManager: EntityManager, skewDirectionBy: CGPoint? = nil, extraCooldown: Double? = nil) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: imageName)
        let spriteComponent = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageName))
        addComponent(spriteComponent)
        if let cooldown = extraCooldown{
            kamikazeComp = KamikazeComponent(node: spriteComponent.node,skewDirectionBy: skewDirectionBy, extraCooldown: cooldown)
        }else{
            kamikazeComp = KamikazeComponent(node: spriteComponent.node,skewDirectionBy: skewDirectionBy)
        }
        addComponent(kamikazeComp!)

        let moveComponent = MoveComponent(maxSpeed: 50, maxAcceleration: 10, effectiveRadius: Float(spriteComponent.node.size.width), entityManager: self.entityManager)
        addComponent(moveComponent)

        let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.searcher.rawValue, dynamicObject: true, canRotate: true, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageName, sprite: spriteComponent.node))
        addComponent(contactComponent)

        let enemyComponent = EnemyComponent()
        addComponent(enemyComponent)

        let guardComponent = GuardComponent()
        addComponent(guardComponent)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}