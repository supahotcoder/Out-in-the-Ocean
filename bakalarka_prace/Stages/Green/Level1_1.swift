//
//  Level1-1.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Level1_1: Level1 {

    private var dialogController: DialogController?
    private var dialogResolution: Int?
    private var dialogStoryResolution: Int?
    private var storyTeller: StoryTeller?
    private var donut: Collectible?
    private var didInteractWithStoryTeller: Bool?
    private var corners = [CGPoint.randomPosition(x: -1300...(-1000), y: 600...700), CGPoint.randomPosition(x: -1300...(-1000), y: -700...(-600)),
                           CGPoint.randomPosition(x: 1000...1300, y: 600...700), CGPoint.randomPosition(x: 1000...1300, y: -700...(-600))]
    private var didDeliverPink = false
    private var didEatGreen = false
    private var lastTouched: SKNode?

    private var storyTellerNode: SKSpriteNode?
    private var didStrangerToldStory: Bool = false
    private var triggerComponent: TriggerComponent?
    private let finalText: [String] = ["So you know next you will have to pass through a maze and find a warper.","You'll have to be careful the creatures down there are dangerous.","Take care and eat some donuts!","Just remember one more thing.\nSome creatures don't find you not interesting when you stay still"]

    override func didMove(to view: SKView) {
        // LEVEL FUNCTIONALITY
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.name = "Level1_1"
        playerSpawnPosition = CGPoint(x: 0, y: 320.0)
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level1-1")
//        MUSIC SETUP
        backgroundMusic(fileName: "level1-1-sound", extension: "wav")

        // STORYTELLER SETUP
        storyTeller = StoryTeller(entityManager: entityManager, storyToTell: [""], triggerable: true, imageNamed: "bigeyyy")
        if let sNode = storyTeller?.component(ofType: SpriteComponent.self)?.node {
            storyTellerNode = sNode
            sNode.position = CGPoint.randomPosition(x: -10...10, y: -10...10)
            sNode.zRotation = CGFloat(0)
            sNode.zPosition = 3
            entityManager.add(entity: storyTeller!)
            updateStoryText(with: "Come to me I have a tale to tell.", around: sNode, forDuration: 1.5)
        }
        if let triggerComp = storyTeller?.component(ofType: TriggerComponent.self){
            triggerComponent = triggerComp
            triggerComp.didTrigger()
        }

        // WANDER SETUP & INITIAL TEXTS
        self.updateStoryText(with: "Play around and find out", around: self.entityManager.loadWander(messages: ["Did you talk with the big eye?", "Not many eyes can see the truth","You know that all the donuts\nare always hidden near the corners of this place?"], position: CGPoint.randomPosition(x: -840...840, y: -640...640))!, forDuration: 1)
        let wander = entityManager.loadWander(messages: ["Hello", "Have you seen the donuts?", "There are four funky donuts","The best idea is to eat\nthe pink donut first and then the green one!"], loopOn: 3, position: CGPoint.randomPosition(x: -1280...1280, y: -640...640))!
        entityManager.loadWander(messages: ["Hello", "Have you seen the donuts?", "There are four funky donuts"], loopOn: 3, position: CGPoint.randomPosition(x: -1280...1280, y: -640...640))
        entityManager.loadWander(messages: ["I've heard that there is a maze close from here\nand you know...they could be there!", "There is one funky donut", "I feel you"], loopOn: 3, position: CGPoint.randomPosition(x: -1280...1280, y: -640...640))
        entityManager.loadWander(messages: ["Hey, stranger", "I might talk nonsense times", "Have you tried the combination\nof pink and green donut?"], loopOn: 3, position: CGPoint.randomPosition(x: -1280...1280, y: -640...640))
        self.updateStoryText(with: "Alright I should explore this place\nand interact with those creatures, I think.", around: self.playerNode!, forDuration: 1)


        //      FEEDBACK SETUP
        var touchF: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        touchF[bitmasks.wander] = ["Find the big eye", "Only he got the knowledge", "Don't touch me alright?"]
        touchF[bitmasks.storyTeller] = ["Hello", "Oh yeah get as low as you can", "Did you find it?", "Go lower"]

        var hintF: Dictionary<GKEntity, [String]> = Dictionary<GKEntity, [String]>()
        hintF[wander.entity!] = ["I should find some other creatures"]
        hintF[storyTeller!] = ["That big guy told me something important"]
        
        var hintP: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        hintP[bitmasks.wander] = ["Hmm why do they need so many eyes"]
        hintP[bitmasks.storyTeller] = ["That big guy looks more pissed each time I bump him"]
        hintP[bitmasks.collectible] = ["This looks like something that doesn't belong here", "I want to eat it, but I don't know"]
        hintP[bitmasks.frame] = ["I think I can't go further.","I may try to break through,\nbut I doubt that it will be useful"]

        let feedback = FeedbackComponent(feedbackHint: hintF, feedbackTouch: touchF, feedbackPlayer: hintP)
        entityManager.addComponentToPlayer(component: feedback)

//        DIALOG SETUP
        dialogController = DialogController(gameScene: self)

        corners.shuffle()
        spawnDecoyDonut(cornerNum: 0)
        spawnDecoyDonut(cornerNum: 1)
        spawnDecoyDonut(cornerNum: 2)
        spawnDonut()
    }

    private func spawnDecoyDonut(cornerNum: Int) {
        let d = Collectible(imageNamed: "donut", size: CGSize(width: 70, height: 70), id: String(-cornerNum), protectable: false, entityManager: entityManager, location: corners[cornerNum])
        let node = d.spriteComp.node
        node.zPosition = 5
        switch cornerNum {
        case 0:
            node.run(SKAction.colorize(with: .magenta, colorBlendFactor: 1, duration: 1))
        case 1:
            node.run(SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 1))
        case 2:
            node.run(SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 1))
        default:
            node.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.9, duration: 1))
        }
        entityManager.add(entity: d)
    }

    func spawnDonut() {
        donut = Collectible(imageNamed: "donut", size: CGSize(width: 70, height: 70), id: "1", protectable: false, entityManager: entityManager, location: corners[3])
        if let node = donut?.spriteComp.node {
            node.zPosition = 5
            node.run(SKAction.repeatForever(.sequence([.wait(forDuration: 0.5), SKAction.run({ () in node.run(SKAction.applyImpulse(CGVector(dx: Int.random(in: -15...15), dy: Int.random(in: -15...15)), duration: 0.3)) })])))
        }
        entityManager.add(entity: donut!)
    }

    func nextLevel(didTriggerPlayer: Bool) {
        changingLevel = true
        if didTriggerPlayer{
            UserDefaults.standard.set(true, forKey: "Level1_2S_by_player")
            UserDefaults.standard.synchronize()
            let nextlevel = "Level1_2S"
            saveLevel(levelName: nextlevel)
            if let scene = SKScene(fileNamed: nextlevel) {
                (scene as? Level1_2S)?.didPlayerAteDonuts = true
                self.removeAllActions()
                self.removeAllChildren()
                self.view?.presentScene(scene)
            }
        }else{
            UserDefaults.standard.set(false, forKey: "Level1_2S_by_player")
            UserDefaults.standard.synchronize()
            let nextlevel = "Level1_2"
            saveLevel(levelName: nextlevel)
            if let scene = SKScene(fileNamed: nextlevel) {
                self.removeAllActions()
                self.removeAllChildren()
                self.view?.presentScene(scene)
            }
        }
    }

    override func didBegin(_ contact: SKPhysicsContact) {
//        prvni nazor hrace a pote az se zobrazi dialog
        super.didBegin(contact)
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        } else {
            return
        }
        if let entity = otherNode.node?.entity {
            let feedbackComp: FeedbackComponent? = entityManager.player?.component(ofType: FeedbackComponent.self)
            saveFeedback(feedback: (feedbackComp?.giveFeedbackHint(on: entity))!)
        }
//        DIALOG RESOLUTIONS
//        1. PINK DONUT IS EATEN
//        2. PINK DONUT IS PUSHED
//        3. GREEN DONUT IS EATEN
//        4. GREEN DONUT IS PUSHED
        if !(dialogController?.active ?? false) && otherNode.node != lastTouched && dialogController?.finished ?? false
                   && otherNode.categoryBitMask == bitmasks.collectible.rawValue {
//            if (dialogStoryResolution ?? 0) == 2 || ((dialogStoryResolution ?? 0) == 4 && otherNode.node?.name == "-2") {
            if otherNode.node?.name == "1"{
//                dialog pink
                dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 1), dialog2TextAndID: ("Push it", 2))
            }else if otherNode.node?.name == "-2"{
//                dialog green
                if didDeliverPink{
                    dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 4), dialog2TextAndID: ("Push it", 5))
                }else{
                    dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 3), dialog2TextAndID: ("Push it", 5))
                }
            }
//            }
            else {
                print("other dialog")
                dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 3), dialog2TextAndID: ("Push it", 5))
            }
            print("Showing dialog")
            pauseGameState()
            playerNode?.isPaused = true
            dialogController?.showDialog(parentNode: camera!);
        }
        lastTouched = otherNode.node
    }

    private func applyPenalty(nodeCausedThis: String?) {
        switch nodeCausedThis {
        case "0":
            playerNode?.run(SKAction.repeat(.sequence([.wait(forDuration: 0.5), SKAction.run({ () in self.playerNode?.run(SKAction.applyImpulse(CGVector(dx: Int.random(in: -50...50), dy: Int.random(in: -50...50)), duration: 0.3)) })]), count: 50))
        case "-1":
            gameOver()
        case "-2":
            warpAnimation(position: playerNode?.position ?? CGPoint(x: 5000, y: 5000))
            playerNode?.run(.colorize(with: .green, colorBlendFactor: 0.9, duration: 1))
            if donut?.collected ?? false {
                playerNode?.run(SKAction.sequence([.wait(forDuration: 0.4), SKAction.run({ () in self.nextLevel(didTriggerPlayer: true) })]))
            }
        default:
            playerNode?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.9, duration: 1))
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!(dialogController?.finished ?? false)) {
                dialogStoryResolution = dialogController?.dialogResolution(touches: touches, touchedIn: camera!)
                if dialogStoryResolution != nil {
                    if dialogStoryResolution! == 1 {
//                        DONUT IS COLLECTED
                        triggerComponent?.finished()
                        print("collected - player way")
                        donut?.collect()
                        storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story: ["Hey you ate it!", "Alright then find yourself a way out"])
                    } else if dialogStoryResolution! == 2 {
//                        DONUT IS REMOVED NOT COLLECTED
                        print("will be removed - story")
                        didDeliverPink = true
                        if !didEatGreen{
                            storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story:
                            ["Perfect you found it! So, yummy!", "Now, follow my instructions carefully\nand you'll be able to get to the depths.","Now you need to find and eat green donut, then come back to me."],
                                    completion: { () in
                                        print("removed")
                                        if self.donut != nil {
                                            self.entityManager.remove(entity: self.donut!)
                                        }
                                        self.triggerComponent?.finished()
                                    })
                        }else{
                            storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story:
                            ["Perfect you found it! So, yummy!", "Oh I see that you have already ate the green donut"] + finalText,
                                    completion: { () in
                                        self.resumeGameState()
                                        self.playerNode?.run(SKAction.sequence([.wait(forDuration: 7),.applyImpulse(CGVector(dx: 0, dy: -500), duration: 1), .wait(forDuration: 0.7), SKAction.run({ () in self.nextLevel(didTriggerPlayer: false) })]))
                                    })
                        }
                    } else if dialogStoryResolution! == 4 {
                        (entityManager.findEntity(entityNodeName: "-2") as? Collectible)?.collect()
                        storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story:
                        ["You made it, great!"],
                                completion: { () in
                                    self.resumeGameState()
                                    self.playerNode?.run(SKAction.sequence([.wait(forDuration: 8),.applyImpulse(CGVector(dx: 0, dy: -500), duration: 1), .wait(forDuration: 0.7), SKAction.run({ () in self.nextLevel(didTriggerPlayer: false) })]))
                                })
                    }
                 else {
                    dialogResolution = dialogController?.dialogResolution(touches: touches, touchedIn: camera!)
                    if dialogResolution != nil {
                        if dialogResolution! == 3 {
                            switch lastTouched?.name {
                            case "0":
                                (entityManager.findEntity(entityNodeName: "0") as? Collectible)?.collect()
                                applyPenalty(nodeCausedThis: "0")
                            case "-1":
                                (entityManager.findEntity(entityNodeName: "-1") as? Collectible)?.collect()
                                applyPenalty(nodeCausedThis: "-1")
                            case "-2":
                                (entityManager.findEntity(entityNodeName: "-2") as? Collectible)?.collect()
                                dialogStoryResolution = 3
                                didEatGreen = true
                                applyPenalty(nodeCausedThis: "-2")
                            case .none: break
                            case .some(_): break
                                }
                            }
                        }
                    }
                resumeGameState()
                }
        }
        super.touchesBegan(touches, with: event)
    }

    override func update(_ currentTime: TimeInterval) {
        if !didStrangerToldStory && ((playerNode?.position)! - (storyTellerNode?.position)!).length() < 300 {
            didStrangerToldStory = true
            updateStoryText(with: "Hello traveler!", around: storyTellerNode!)
            updateStoryText(with: "Hello. I'm looking for a way to get to deeper depths.", around: playerNode!)
            updateStoryText(with: "Interesting place, I'm sure.\nThe creatures down there are weird and wonderful. ", around: storyTellerNode!)
            updateStoryText(with: "Do you know a way to get there?", around: playerNode!)
            updateStoryText(with: "Ah, I might be able to help you, traveler.\nIn exchange, I'd like a yummy pink donut.", around: storyTellerNode!)
            updateStoryText(with: "Alright, then. Let me know when you have the donut\nand I'll tell you how to get to the depths.", around: playerNode!)
        }

        if  ((storyTellerNode?.position)! - (donut?.spriteComp.node.position)!).length() < 300{
            triggerComponent?.didTrigger()
        }else if (dialogResolution == 2) || (dialogResolution == 4){
            triggerComponent?.canceled()
        }
        super.update(currentTime)
    }
}
