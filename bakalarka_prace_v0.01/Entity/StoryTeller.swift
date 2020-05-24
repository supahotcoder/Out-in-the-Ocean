//
//  StoryTeller.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 01/07/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class StoryTeller: GKEntity {

    private let entityManager : EntityManager
    private var storyComp: StoryComponent?

    // STATIC UNIT
    init(entityManager: EntityManager, storyToTell: [String],completion: (() -> Void)? = nil) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: "big_talk")
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: CGSize(width: 200, height: 200))
        addComponent(spriteComp)

        storyComp = StoryComponent(node: spriteComp.node, story: storyToTell, entityManager: entityManager,completion: completion)
        addComponent(storyComp!)

        let avoidComp = AvoidCollisionComponent()
        addComponent(avoidComp)

        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.storyTeller.rawValue, dynamicObject: true, canRotate: false, mass: 20)
        addComponent(contactComp)
        // je statická moveComponent používá jenom pro zjišťování vzdálenosti od hráče
        // DUE TO SOME UNEXPLAINABLE PROBLEMS EVEN STATIC ENTITY HAS TO MOVE SO IT WOULDN'T HAD POSITION (nal, nal)
        let moveComp = MoveComponent(maxSpeed: 1, maxAcceleration: 40, effectiveRadius: Float(spriteComp.node.size.width / 2), entityManager: self.entityManager)
        addComponent(moveComp)
    }
    
    
//    CAN BE USED TO TELL ADDITIONAL STORY AFTER SOME IN-GAME CONDITION
    func addAnotherStory(story: [String],completion: (() -> Void)? = nil) {
        storyComp?.addAnotherStory(story: story,completion: completion)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
