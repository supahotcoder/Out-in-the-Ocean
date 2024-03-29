//
//  StoryTeller.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class StoryTeller: GKEntity {

    private let entityManager : EntityManager
    private var storyComp: StoryComponent?

    // STATIC UNIT
    init(entityManager: EntityManager, storyToTell: [String], triggerable: Bool = false, completion: (() -> ())? = nil, imageNamed: String) {
        self.entityManager = entityManager
        super.init()

        let texture = SKTexture(imageNamed: imageNamed)
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: BodyPathsBodySizes.getBodySize(textureName: imageNamed))
        addComponent(spriteComp)

        storyComp = StoryComponent(node: spriteComp.node, story: storyToTell, entityManager: entityManager,completion: completion)
        addComponent(storyComp!)

        let avoidComp = AvoidCollisionComponent()
        addComponent(avoidComp)

        if triggerable{
            let trigger = TriggerComponent()
            addComponent(trigger)
        }

        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.storyTeller.rawValue, dynamicObject: true, canRotate: false, pathBody: BodyPathsBodySizes.getPhysicsBodyOf(textureName: imageNamed, sprite: spriteComp.node), mass: 60)
        addComponent(contactComp)
        // je statická moveComponent používá jenom pro zjišťování vzdálenosti od hráče
        // DUE TO SOME UNEXPLAINABLE PROBLEMS EVEN STATIC ENTITY HAS TO MOVE SO IT WOULDN'T HAD POSITION (nal, nal)
        let moveComp = MoveComponent(maxSpeed: 1, maxAcceleration: 30, effectiveRadius: Float(spriteComp.node.size.width / 2), entityManager: self.entityManager)
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
