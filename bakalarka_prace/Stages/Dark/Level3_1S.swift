//
//  Level3_1S.swift
//
//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level3_1S: LevelStory {

    private var sideStoryCompleted: Bool = false

    override func didMove(to view: SKView) {
        self.name = "Level3_1S"
        // BACKGROUND BOUNDARY
        background = childNode(withName: "background") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        //MUSIC SETUP
        backgroundMusic(fileName: "level3-1S-sound", extension: "wav")
        playerSpawnPosition = CGPoint(x: 0, y: 270)
        // Bubble effect
        let bubblesback = SKEmitterNode(fileNamed: "SmogEffect")!
        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        bubblesback.particlePositionRange = backgroundRange
        bubblesback.position = CGPoint(x: 0, y: 0)
        self.addChild(bubblesback)
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level3-1S")
        mainStoryTellerNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "diamantier", triggerable: false, position: CGPoint(x: 150, y: 300), rotation: CGFloat(0)).node

        updateStoryText(with: "Wait, I just used the crystal key to get here!\nWhy am I here and not where I wanted to be?", around: playerNode!)
        updateStoryText(with: "Ah, there's more to it than that.\nYou see, the crystal key is just one of twelve keys of mindful teleportation.", around: mainStoryTellerNode!)
        updateStoryText(with: "If want to teleport correctly, you must have at least two keys.", around: mainStoryTellerNode!)
        updateStoryText(with: "Otherwise, no matter how clean a mind you have, it will never work.", around: mainStoryTellerNode!)
        updateStoryText(with: "Many have tried to use only one key to go where they pleased.\nBut only found themselves in an interdimensional state of madness.", around: mainStoryTellerNode!)
        updateStoryText(with: "Everyone who enters there will eventually evaporate\nas the constant shifting between dimensions becomes too much for their body to handle.", around: mainStoryTellerNode!)
        updateStoryText(with: "Then the key is then imploded and thrown back in the world,\nwhere it can be near impossible to find.", around: mainStoryTellerNode!)
        updateStoryText(with: "You're lucky that you have found one.\nThe key might been there for thousands of years.", around: mainStoryTellerNode!)
        updateStoryText(with: "I have found two of them, but there was one slimy guy who has stole one from me!", around: playerNode!)
        updateStoryText(with: "I have to finish my quest so I need the second key.\nCould you help me?", around: playerNode!)
        updateStoryText(with: "Hmmm interesting, that gives me an idea.", around: mainStoryTellerNode!)
        updateStoryText(with: "Your best chance at obtaining a second key without searching for eternity is to take a daring risk.", around: mainStoryTellerNode!)
        updateStoryText(with: "Enter the interdimensional madness and search for another entity with a key", around: mainStoryTellerNode!)
        updateStoryText(with: "If the key was stolen recently the entity could still be there.\nIf it doesn't have a second key.", around: mainStoryTellerNode!)
        updateStoryText(with: "You will probably have to collide with the entity as it's going to teleport.\nThat could trigger key symbiosis.", around: mainStoryTellerNode!)
        updateStoryText(with: "It will only work once, but it may well be worth it.", around: mainStoryTellerNode!)
        updateStoryText(with: "But beware, the place is incredibly dangerous and you must be prepared for anything.", around: mainStoryTellerNode!)
        updateStoryText(with: "You must also use your mind carefully, as the interdimensional madness can make even the sanest of minds mad.", around: mainStoryTellerNode!)
        updateStoryText(with: "Once you have the second key, you can use it to teleport to the exact location you wish.", around: mainStoryTellerNode!)
        updateStoryText(with: "Just be sure you are very specific about the location from the bottom of your heart.", around: mainStoryTellerNode!)
        updateStoryText(with: "When you are ready, bump me\nand I will put your mind into peace for your journey.", around: mainStoryTellerNode!)

        entityManager.loadWander(messages: ["..."],imageName: "mudder", warningMsgs: [""], position: CGPoint.randomPosition(x: -320...230, y: -400...(-100)), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .systemPink, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["I'm calm for now."],imageName: "mudder", warningMsgs: [""], position: CGPoint.randomPosition(x: -120...130, y: -400...(-100)), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .systemPink, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Don't bother"],imageName: "mudder", warningMsgs: [""], position: CGPoint.randomPosition(x: -150...120, y: -400...(-100)), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .orange, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["I'm not here to have a friendly chat"],imageName: "mudder", warningMsgs: [""], position: CGPoint.randomPositionAvoidNode(x: -220...220, y: -500...(-50), nodeToAvoid: playerNode!), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.3, duration: 0))

        let helpfulStoryNode = entityManager.loadStoryTeller(storyToTell: ["I heard you wish to venture to an interdimensional state.",
                                                                           "But be warned that place is very unstable and there are innumerable dangers.",
                                                                           "The energies of the interdimensional place\nare constantly shifting and the creatures that inhabit it are dangerous.",
                                                                           "Be sure to stay on track and focus on your end goal."],completion: {self.sideStoryCompleted = true}, imageNamed: "cupcakeus", triggerable: false, position: CGPoint(x: -120, y: -350), rotation: CGFloat(0)).node
        helpfulStoryNode?.run(SKAction.colorize(with: .purple, colorBlendFactor: 0.5, duration: 0))
        
        var touchF: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        touchF[bitmasks.wander] = ["I don't feel like talking to you","..."]

        let feedback = FeedbackComponent(feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)
    }


    func nextLevel(){
        changingLevel = true
        let nextLevel = "Level3_1"
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
