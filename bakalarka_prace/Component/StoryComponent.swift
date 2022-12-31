//
//  StoryComponent.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class StoryComponent: GKComponent {
    
    private var msg = SKLabelNode(text: "")
    private var current = 0
    
    private var story: [String]
    private let entityManager: EntityManager
    private let entityNode: SKSpriteNode
    private var completion: (() -> Void)?
    private(set) var finished = false
    
    init(node: SKSpriteNode, story: [String], entityManager: EntityManager,completion: (() -> Void)? = nil){
        self.story = story
        self.entityManager = entityManager
        entityNode = node
        self.completion = completion
        super.init()
    }
    
    func tellStory() {
        if msg.parent == nil && current < story.count {
            prepareMsg(with: story[current], fadeIn: 0.2, fadeOut: 0.7)
            current += 1
            if current < story.count, !finished{
                completion?()
                finished = true
            }
        }
    }
    
    private func prepareMsg(with text: String,fadeIn: TimeInterval, fadeOut: TimeInterval){
        msg = entityManager.tellStory(text: text, around: entityNode,fadeIn: fadeIn, fadeOut: fadeOut)!
    }
    
    func addAnotherStory(story: [String],completion: (() -> Void)? = nil) {
        finished = false
        self.story = story
        self.completion = completion
        current = 0
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
