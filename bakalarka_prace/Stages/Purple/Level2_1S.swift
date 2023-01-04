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
        // Bubble effect
        let bubblesback = SKEmitterNode(fileNamed: "BubbleEffect")!

        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        bubblesback.particlePositionRange = backgroundRange
        bubblesback.run(.colorize(with: .purple, colorBlendFactor: 0.8, duration: 0))
        bubblesback.position = CGPoint(x: 0, y: 0)
        self.addChild(bubblesback)
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
        entityManager.loadWander(messages: ["Oh you're heading for the unknown?","You know kamikaze?","Well you about to learn what\nthat name really means, haha!"], warningMsgs: [""], position: CGPoint.randomPosition(x: -100...330, y: -400...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .systemPink, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Be careful, but wait do I even care?","Watch out for crystalios they are crazy!","You will learn"], warningMsgs: [""], position: CGPoint.randomPosition(x: -100...330, y: -400...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .orange, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Mind your own business"], warningMsgs: [""], position: CGPoint.randomPosition(x: -120...120, y: -100...330), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.3, duration: 0))
        let helpfulStoryNode = entityManager.loadStoryTeller(storyToTell: ["Did you talk with the slimy face?",
                                                                           "Be careful I don't trust him.",
                                                                           "Somewhere within that cave is a key\nthat can grant you the power to travel anywhere you desire.",
                                                                           "Many are seeking this power...",
                                                                           "If you have clear mind\nyou can just imagine a place you would like to visit",
                                                                           "Doubts will make you lose your mind.",
                                                                           "Just remember be ready, always."],completion: {self.sideStoryCompleted = true}, imageNamed: "wander", triggerable: false, position: CGPoint(x: 120, y: -350), rotation: CGFloat(0)).node

        helpfulStoryNode?.run(SKAction.colorize(with: .purple, colorBlendFactor: 0.5, duration: 0))
        
        var touchF: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        touchF[bitmasks.wander] = ["What do you want?","There is a cave in which\nyou can die by just touching a crystal!","Alright you are kinda\ninvading my personal space","Hey stop touching me I'm serious","Can you leave me alone?!","This is your last and final warning!","I mean yes the cave,\nyou can find one key in top right corner","Can you leave me alone?\nI've told you everything!","","","","","","","","","","","","","","",""]

        let feedback = FeedbackComponent(feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)
    }


    func nextLevel(){
        changingLevel = true
        let nextLevel = "Level2_1"
        if let scene = SKScene(fileNamed: nextLevel) {
            if sideStoryCompleted{
                UserDefaults.standard.set(true, forKey: "Level2_1_side_story")
                UserDefaults.standard.synchronize()
                (scene as? Level2_1)?.didPlayerGatheredInfo = true
            }else{
                UserDefaults.standard.set(false, forKey: "Level2_1_side_story")
                UserDefaults.standard.synchronize()
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
