//
//  Level-2-1-story.swift
//
//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level2_1S: LevelStory {

    private var sideStoryCompleted: Bool = false

    override func didMove(to view: SKView) {
        self.name = "Level2_1S"
        // BACKGROUND BOUNDARY
        background = childNode(withName: "pozadi") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        //MUSIC SETUP
        backgroundMusic(fileName: "level2-1-story", extension: "wav")
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level2-1S")
            
        mainStoryTellerNode = entityManager.loadStoryTeller(storyToTell: ["Greetings, traveler.\nI've heard you're looking for something special.",
                                                                          "I have a tale for that to tell.",
                                                                          "I have heard of a place far away,\nwhere there are many magical crystals hidden inside a cave.",
                                                                          "Ah, the crystal cave. That place is full of danger.",
                                                                          "Many have tried to find the crystals, but none have succeeded.",
                                                                          "It's said that deep within the cave lies\na key that can unlock the secrets of travel.",
                                                                          "That sounds like an interesting place to explore, right?\nBut be careful, many have tried to get the key and ended up going crazy.",
                                                                          "I may be able to help you.\nI can also show you how to get to the crystal cave safely.",
                                                                          "If you give me the key,\nI will show you how to use it to travel anywhere you want.",
                                                                          "Very well, bump me when you will be done with wandering around."], imageNamed: "slime", triggerable: false, position: CGPoint(x: 150, y: 300), rotation: CGFloat(0)).node
        entityManager.loadWander(messages: ["Oh you're heading for the unknown?"], warningMsgs: [""], position: CGPoint.randomPosition(x: -100...330, y: -400...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .systemPink, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Be careful, but wait do I even care?"], warningMsgs: [""], position: CGPoint.randomPosition(x: -100...330, y: -400...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .orange, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Mind your own business"], warningMsgs: [""], position: CGPoint.randomPosition(x: -120...120, y: -100...330), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.3, duration: 0))
        let helpfulStoryNode = entityManager.loadStoryTeller(storyToTell: ["Did you talk with the slimy face?",
                                                                           "Be careful I don't trust him.",
                                                                           "Somewhere within this cave is a key\nthat will grant you the power to travel anywhere you desire.",
                                                                           "Many are seeking this power...",
                                                                           "If you have clear mind you can just imagine a place you would like to visit",
                                                                           "Doubts will make you lose your mind.",
                                                                           "Just remember be ready, always."],completion: {self.sideStoryCompleted = true}, imageNamed: "wander", triggerable: false, position: CGPoint(x: -120, y: -350), rotation: CGFloat(0)).node

        helpfulStoryNode?.run(SKAction.colorize(with: .purple, colorBlendFactor: 0.5, duration: 0))
    }


    func nextLevel(){
        changingLevel = true
        let nextLevel = "Level2_1"
        if let scene = SKScene(fileNamed: nextLevel) {
            if sideStoryCompleted{
                (scene as? Level2_1)?.didPlayerGatheredInfo = true
            }
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: nextLevel)
            self.view?.presentScene(scene)
        }
    }

    override func didBumpIntoStoryTeller() {
        nextLevel()
    }

    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
