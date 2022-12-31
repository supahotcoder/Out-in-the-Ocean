//
//  Wander.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class Wander: GKEntity {

    private let entityManager: EntityManager

    //INTERACTION INIT
    init(imageName: String = "wander", entityManager: EntityManager, messages: [String], loopMessagesOn: Int? = nil, warningMsgs: [String]) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: imageName)

        let spriteComp = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageName))
        addComponent(spriteComp)

        let msgComp = MessageComponent(node: spriteComp.node, entityManager: entityManager, messages: messages, loopOn: loopMessagesOn, warningMsgs: warningMsgs)
        addComponent(msgComp)

        //TODO: - Avoid || Not
        let avoidComp = AvoidCollisionComponent()
        addComponent(avoidComp)

        let moveComp = MoveComponent(maxSpeed: 40, maxAcceleration: 20, effectiveRadius: Float(spriteComp.node.size.width), entityManager: self.entityManager)
        addComponent(moveComp)

        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.wander.rawValue, dynamicObject: true, canRotate: true, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageName, sprite: spriteComp.node), mass: 5)
        addComponent(contactComp)
    }

    //NO INTERACTION INIT
    init(imageName: String = "wander", entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: imageName)

        let spriteComp = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageName))
        addComponent(spriteComp)

        //TODO: - Avoid || Not
        let avoidComp = AvoidCollisionComponent()
        addComponent(avoidComp)

        let moveComp = MoveComponent(maxSpeed: 40, maxAcceleration: 20, effectiveRadius: Float(spriteComp.node.size.width), entityManager: self.entityManager)
        addComponent(moveComp)

        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.wander.rawValue, dynamicObject: true, canRotate: true, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageName, sprite: spriteComp.node), mass: 5)
        addComponent(contactComp)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
