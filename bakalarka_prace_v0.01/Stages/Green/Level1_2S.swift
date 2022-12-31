//
//  Level1_2S.swift
//
//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class Level1_2S: LevelStory {

    var didPlayerAteDonuts: Bool = false

    override func didMove(to view: SKView) {
        name = "Level1_2S"
        background = childNode(withName: "background") as? SKSpriteNode
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
//      bigeyyy big_talk
        playerSpawnPosition = CGPoint(x: 0, y: 320.0)
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level1-2S")
//        BACKGROUND SOUND SETTING
        backgroundMusic(fileName: "level1-2S-sound", extension: "wav")
//      SETUP STORY
        mainStoryTellerNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "huh", triggerable: false, position: CGPoint(x: 150, y: 300), rotation: CGFloat(0)).node

        if didPlayerAteDonuts {
            updateStoryText(with: "Ah, I can't believe someone would try\nto eat the same donuts as the last guy and end up here!", around: mainStoryTellerNode!)
            updateStoryText(with: "That must have been hell of the trip I can say.", around: mainStoryTellerNode!)
            updateStoryText(with: "Big respect for that.", around: mainStoryTellerNode!)
            updateStoryText(with: "You are good listener then, because that guy couldn't stop talking about his funky donuts haha!", around: mainStoryTellerNode!)
            updateStoryText(with: "How can I help you?", around: mainStoryTellerNode!)
        } else {
            updateStoryText(with: "Hey you! Where do you think you're headed?\nYou sure don't belong here!", around: mainStoryTellerNode!)
        }
        updateStoryText(with: "I'm on a mission. I'm looking for an secret element in depths of this world.", around: playerNode!)
        updateStoryText(with: "Could you help me to get closer to my goal?", around: playerNode!)
        updateStoryText(with: "Ahh, that! Well, that is the secret element\nknown to only a few, the Unifying Force.", around: mainStoryTellerNode!)
        updateStoryText(with: "A powerful element that is potentially\nincredibly dangerous and should never fall into the wrong hands.", around: mainStoryTellerNode!)
        updateStoryText(with: "That could be used to enslave species! Beware of it.", around: mainStoryTellerNode!)
        updateStoryText(with: "Ok that was the warnings now straight to the point.\nYou need to set up a warper. It'll help you get to your destination a way faster.", around: mainStoryTellerNode!)
        updateStoryText(with: "But be warned, there is an entity guarding the element.\nThey call it, Reverso. It is all powerful, and it defends the element at all costs.", around: mainStoryTellerNode!)

        updateStoryText(with: "Alright, I'll be careful. Thanks for the warning.", around: playerNode!)
        updateStoryText(with: "But something else you should know,\nThe Unifying Force is something very powerful, and can be used for good or evil.", around: mainStoryTellerNode!)
        updateStoryText(with: "So, if you are going to be able capture it.\nBe sure to use it wisely.", around: mainStoryTellerNode!)
        updateStoryText(with: "When you are ready to go, bump into me.", around: mainStoryTellerNode!)


        entityManager.loadWander(messages: ["Hello again traveler,\nI see that you're on a good track"], imageName: "bigeyyy", warningMsgs: [""], position: CGPoint.randomPosition(x: -220...330, y: -300...(-100)), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .yellow, colorBlendFactor: 0.6, duration: 0))
        entityManager.loadWander(messages: ["Have a good time.\nI mean this place is awesome!"], warningMsgs: [""], position: CGPoint.randomPosition(x: -150...200, y: -300...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .orange, colorBlendFactor: 0.8, duration: 0))
        entityManager.loadWander(messages: ["Stay here with us, nothing good is down there"], warningMsgs: [""], position: CGPoint.randomPosition(x: -120...170, y: -300...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.9, duration: 0))
        entityManager.loadStoryTeller(storyToTell: ["Hello there! Say, have I got a story for you!",
                                                    "Well, the other night I was getting hungry, so I decided to have a few donuts.\nLittle did I know what I was getting myself into.",
                                                    "See, this one guy I know was telling me about this donut story.\nYou might have heard that but never mind.",
                                                    "I saw something that had the power to bend the laws of reality.",
                                                    "All you had to do was eat a certain number of donuts and something amazing would happen.",
                                                    "I don’t really remember how many I ate though",
                                                    "Next it was like I was suddenly transported to another dimension.",
                                                    "Everything around me was a strange, distorted mess and I was going faster and faster.",
                                                    "I know, it was pretty wild!",
                                                    "I still feel the effects of that experience.\nI don’t remember much of what happened, but it was definitely one hell of a ride."], imageNamed: "big_talk", triggerable: false, position: CGPoint(x: -120, y: -350), rotation: CGFloat(0))

        entityManager.loadStoryTeller(storyToTell: ["Wait stranger!\nYou remind me of one entity I've encountered.",
                                                    "It was like a white creature, or a spirit, I had never seen before.",
                                                    "I remained motionless and watched, and ever so slowly,\nI could feel the creature's intentions shifting.",
                                                    "Well, it was as if the creature was there to protect something, something very precious indeed.",
                                                    "I could feel it in the air as it lingered,\nas if it was trying its best to communicate to me through mysterious and tender means.",
                                                    "I think that I have understood its plan,\nwhich was to protect this place and everything in it.",
                                                    "No matter what I was happy that I didn't move at all so it didn't change it's intentions.",
                                                    "That's why we may never fully understand what lies beyond the veil."], imageNamed: "wander", triggerable: false, position: CGPoint(x: 550, y: 400), rotation: CGFloat(0))
    }

    override func didBumpIntoStoryTeller() {
        nextLevel()
    }

    func nextLevel() {
        changingLevel = true
        let nextlevel = "Level1_3"
        if let scene = SKScene(fileNamed: nextlevel) {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: nextlevel)
            self.view?.presentScene(scene)
        }
    }
}
