//
// Created by Janko on 27.12.2022.
// Copyright (c) 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

protocol StoryLevelProtocol {
    func didBumpIntoStoryTeller()
}

typealias LevelStory = LevelStoryClass & StoryLevelProtocol

class LevelStoryClass: GameScene {

    internal var mainStoryTellerNode: SKSpriteNode?{
        didSet{
            mainStoryTellerNode?.name = "main"
        }
    }

    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }

    func gameOver() {
//  Game over v pribehovych urovnich nebyva
    }

    func didBumpIntoStoryTeller(){
        fatalError("didBumpIntoStoryTeller() has not been implemented")
    }


    func didBegin(_ contact: SKPhysicsContact) {
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        } else {
            return
        }
        if otherNode.node?.physicsBody?.categoryBitMask == mainStoryTellerNode?.physicsBody?.categoryBitMask{
            if storyTellingActions.isEmpty && otherNode.node?.name == "main" {
                didBumpIntoStoryTeller()
            }
        }
    }
}
