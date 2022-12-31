//
//  Level0_1.swift
//
//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation



class Level0_1: LevelStory {
    
    private var didFinishStory: Bool = false
    private var helpfulStoryNode: SKSpriteNode?
    private var didStrangerToldStory: Bool = false
    private var lastBumpTime: Date = Date()

    override func didMove(to view: SKView) {
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.name = "Level0_1"
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        playerSpawnPosition = CGPoint(x: 200,y: 120)
        
        super.didMove(to: view)
//        HELP SETUP
        helpBox = HelpBox(levelName: "level0-1")
        // pokus otoceni hrace na pribehovou postavu
        playerNode?.zRotation = 0.7

//       LOAD EXIT LEVEL WARPER
        let warper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        let warperNode = warper.component(ofType: SpriteComponent.self)!.node
        warperNode.zPosition = 4
        warperNode.run(SKAction.rotate(byAngle: 90, duration: 600))
        warperNode.position = CGPoint(x: 620, y: -410)
        warperNode.run(.colorize(with: .orange, colorBlendFactor: 0.6, duration: 0))
        entityManager.add(entity: warper)
//        MUSIC SETUP
        backgroundMusic(fileName: "level0-1-sound", extension: "wav")
        mainStoryTellerNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "plush", triggerable: false, position: CGPoint(x: -20, y: 180), rotation: CGFloat(0)).node

//        MAIN STORY TELLING
        updateStoryText(with: "Oh finally here you are.", around: mainStoryTellerNode!)
        updateStoryText(with: "You’ve been chosen for the mighty quest.", around: mainStoryTellerNode!)
        updateStoryText(with: "The secret element is hidden in the depths of the darkest part of our world.", around: mainStoryTellerNode!)
        updateStoryText(with: "It is the key to unity, peace and happiness.\nYour quest is to find that element and bring it to us.", around: mainStoryTellerNode!)
        updateStoryText(with: "What’s the element? How do I find it?", around: playerNode!)

        updateStoryText(with: "The element is called ‘The Unifying Force’ and it is said to be\nso powerful that no one has ever been able to possess it.", around: mainStoryTellerNode!)
        updateStoryText(with: "You need to find this element.\nAnd then help us to find a way to unlock its power.", around: mainStoryTellerNode!)
        updateStoryText(with: "That sounds impossible.\nHow am I supposed to do that?", around: playerNode!)

        updateStoryText(with: "You must venture into the depths of the world.\nWe have discovered an approximate position of the force.", around: mainStoryTellerNode!)
        updateStoryText(with: "We have set that position into the teleport.", around: mainStoryTellerNode!)
        updateStoryText(with: "The warper, which you have been teleported with\n...ehm...\nI mean it's the big, round and spinning entity.", around: mainStoryTellerNode!)
        updateStoryText(with: "Don't worry you will find it on your way down.", around: mainStoryTellerNode!)
        updateStoryText(with: "I know it is a dangerous journey,\nbut you are brave enough and you will be rewarded greatly.", around: mainStoryTellerNode!)
        updateStoryText(with: "You will be granted a title \"savior of the world\"\nand huge respect from all species.", around: mainStoryTellerNode!)
        updateStoryText(with: "I think I’m ready to take on the challenge.", around: playerNode!)

        updateStoryText(with: "You will face many obstacles and creatures of the deep.\nYou may also need the help of some allies.", around: mainStoryTellerNode!)
        updateStoryText(with: "You may come across some strange creatures, or even some friendly ones.\nAlways bump them or go near the various creatures, they may help you!", around: mainStoryTellerNode!)
        updateStoryText(with: "Unfortunately we haven't explored the depths yet.\nSo this is how much I'm able to tell you", around: mainStoryTellerNode!)
        updateStoryText(with: "How do I find the element? Where should I search?", around: playerNode!)

        updateStoryText(with: "Your mind is a very powerful thing.\nFollow the path that will appear in your head.", around: mainStoryTellerNode!)
        updateStoryText(with: "If you ever get lost remember there are many warpers,\nwho can help you to move where you need to be.", around: mainStoryTellerNode!)
        updateStoryText(with: "In the deepest depths use your memories.\nGo as far into your memories as you can and remember.", around: mainStoryTellerNode!)
        updateStoryText(with: "Now you should be prepared.\nHead down to find a warper.", around: mainStoryTellerNode!)
//      LOAD ENTITIES
        entityManager.loadWander(messages: ["I hope for the good days"],imageName: "player_test", warningMsgs: [""], position: CGPoint.randomPosition(x: -120...130, y: -300...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .systemPink, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Please be careful"],imageName: "player_test", warningMsgs: [""], position: CGPoint.randomPosition(x: -250...320, y: -300...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .orange, colorBlendFactor: 0.3, duration: 0))
        entityManager.loadWander(messages: ["Can't talk"],imageName: "player_test", warningMsgs: [""], position: CGPoint.randomPosition(x: -120...280, y: -300...0), rotation: CGFloat.random(in: 0...360))?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.3, duration: 0))
        helpfulStoryNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "player_test", triggerable: false, position: CGPoint(x: 440, y: -320)).node
        helpfulStoryNode?.run(.colorize(with: .systemPink, colorBlendFactor: 0.7, duration: 0))
//      LOAD SUB-STORY TELLER
        let wanderNode = entityManager.loadStoryTeller(storyToTell: ["Hello there. I have an incredible story to tell.",
                                                                       "You see, I was wandering around and I came across a peculiar set of donuts.",
                                                                       "They were a bright pink and a dark green.",
                                                                       "I was so hungry, I decided to eat them,\nbut I have no recollection of the order I ate them in. ",
                                                                       "I suddenly found myself teleporting to a whole new dimension.\nIt was so far away, and yet I was so intrigued.",
                                                                       "I was able to explore and take in the sights.\nIt was truly an unforgettable experience.",
                                                                       "Teleporting is a great way to travel,\nespecially when you want to go far in a very short amount of time.",
                                                                       "That's how I managed to travel here haha!\nUh even though I'm kinda lost now.",
                                                                       "I'm sure it could help you too with your travel.",
                                                                       "It's really easy. It's been well worth it every time I've done it!",
                                                                       "Just eat those two in correct order and I can guarantee it will save you plenty of time."],
                imageNamed: "wander", triggerable: false, position: CGPoint(x: -420, y: -370)).node!
//        obarveni wanderNode
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        effectNode.shouldEnableEffects = true
        wanderNode.removeFromParent()
        effectNode.zPosition = 3
        effectNode.addChild(wanderNode)
        wanderNode.run(.colorize(with: .purple, colorBlendFactor: 0.8, duration: 0))
        effectNode.filter = CIFilter(name: "CIColorControls", parameters: ["inputSaturation": 3 ,"inputBrightness": 0.2])
        self.addChild(effectNode)
    }

    override func didBumpIntoStoryTeller() {
        if -lastBumpTime.timeIntervalSinceNow > 3{
            updateFeedbackText(with: "Find the warper.\nIt should be ready in right corner at the bottom.", around: mainStoryTellerNode!)
            lastBumpTime = Date()
        }
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        } else {
            return
        }
        if otherNode.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            nextLevel()
        }
    }

    func nextLevel(){
        changingLevel = true
        let nextlevel = "Level1_1"
        joystickNode?.removeAllChildren()
        joystickNode?.removeFromParent()
        playerNode?.removeAllActions()
        saveLevel(levelName: nextlevel)
        let warp = SKEmitterNode(fileNamed: "Warping")!
        let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
        warp.position = playerNode!.position
        warp.zPosition = 2
        self.addChild(warp)
        warp.run(removeWarp)
        waitAndRun(delay: 0.5, function: {() in
            self.playerNode?.run(SKAction.fadeOut(withDuration: 1), completion: {
                self.scene?.run(SKAction.colorize(with: UIColor.init(red: 110/255, green: 230/255, blue: 160/255, alpha: 1), colorBlendFactor: 0.9, duration: 3))
                   self.scene?.run(SKAction.fadeOut(withDuration: 2.5), completion: {
                       if let scene = SKScene(fileNamed: nextlevel) {
                           self.removeAllActions()
                           self.removeAllChildren()
                           self.view?.presentScene(scene)
                       }
                   })
                })
            })
    }
    
    override func update(_ currentTime: TimeInterval) {

        super.update(currentTime)
        if !didStrangerToldStory && ((playerNode?.position)! - (helpfulStoryNode?.position)!).length() < 300 {
//            pred vstupem do warperu bude hracovi sdelen jeste jeden pribeh
            didStrangerToldStory = true

            updateStoryText(with: "I know it all. I have seen and lived through it, I think.", around: helpfulStoryNode!)
            updateStoryText(with: "In the end, there is only you. You have to face it.", around: helpfulStoryNode!)
            updateStoryText(with: "You will be the doom of our species,\nand I cannot say anything else, for it is not safe here. ", around: helpfulStoryNode!)
            updateStoryText(with: "In the end, everything is reversed, and how it should be.", around: helpfulStoryNode!)
            updateStoryText(with: "What do you mean?\nHow can I be the doom of our species?", around: playerNode!)

            updateStoryText(with: "It is something that cannot be explained, nor can it be understood.", around: helpfulStoryNode!)
            updateStoryText(with: "It is something that must be experienced.", around: helpfulStoryNode!)
            updateStoryText(with: "You must face it alone and accept the consequences of your actions.", around: helpfulStoryNode!)
            updateStoryText(with: "It is a journey that will take you to the brink of madness,\nand you must find a way to survive.", around: helpfulStoryNode!)
            updateStoryText(with: "I can tell you no more, for it is too dangerous for both of us.", around: helpfulStoryNode!)
            updateStoryText(with: "But how can I change it?\nHow can I survive? ", around: playerNode!)

            updateStoryText(with: "You have to find that by yourself.", around: helpfulStoryNode!)
            updateStoryText(with: "Be aware of those who pretend to be your friends,\nand use caution when entering unfamiliar or dangerous areas.", around: helpfulStoryNode!)
        }
    }
}
