//
//  StaticBackground.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 10/05/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class StaticBackground: GKEntity {

    private(set) var spriteComp: SpriteComponent

    init(imageName: String, entityManager: EntityManager) {
        spriteComp = SpriteComponent()
        super.init()
        let texture = SKTexture(imageNamed: imageName)
        spriteComp = SpriteComponent(entity: self, texture: texture, size: CGSize(width: 6000, height: 1500))
        addComponent(spriteComp)

        let contactComponent = ContactComponent(entity: self, bitmask: bitmasks.activeBackground.rawValue, dynamicObject: false, canRotate: false, pathBody: BodyPaths.getPhysicsBodyOf(textureName: imageName, sprite: spriteComp.node))
        addComponent(contactComponent)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
