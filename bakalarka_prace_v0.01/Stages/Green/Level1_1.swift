//
//  Level1-1.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 31/03/2019.
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
    private var wasStoryDialog = false
    private var lastTouched: SKNode?

    override func didMove(to view: SKView) {
//        print(CGPoint.randomPosition(x: -1300...(-1000), y: 600...700))
//        print(CGPoint.randomPosition(x: -1300...(-1000), y: -700...(-600)))
//        print(CGPoint.randomPosition(x: 1000...1300, y: 600...700))
//        print(CGPoint.randomPosition(x: 1000...1300, y: -700...(-600)))
        // LEVEL FUNCTIONALITY
        self.background = childNode(withName: "pozadi") as? SKSpriteNode
        self.name = "Level1_1"
        super.didMove(to: view)
        playerNode?.position = CGPoint(x: 0, y: 320.0)
        // TODO: - override name, background, start point, etc.
        #warning("Level1_1 setup missing")

//        MUSIC SETUP
        backgroundMusic(fileName: "level1-1-sound", extension: "wav")

        // STORYTELLER SETUP
        let storyToTell = ["Hello there am I supposed to tell you some wisdom?", "Oh so you assume that, because that I have a huge eye ?!", "You better watch yourself,\nyour only luck is that these green waters are stupid friendly", "Get out of my face already", "Wait wait...", "Maybe if you find this pink round donut, I might be able to help you"]
        storyTeller = StoryTeller(entityManager: entityManager, storyToTell: storyToTell)
        if let sNode = storyTeller?.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: -10...10, y: -10...10)
            sNode.zRotation = CGFloat(0)
            sNode.zPosition = 3
            entityManager.add(entity: storyTeller!)
            updateStoryText(with: "I ain't that big though", around: sNode, timeToFocusOn: 3.3, forDuration: 2)
        }

        // WANDER SETUP & INITIAL TEXTS
        waitAndRun(delay: 3, function: { () in self.updateStoryText(with: "Find out what is this realm about", around: self.entityManager.loadWander(messages: ["One is kinda tricky though", "No eye sees the truth"])!, timeToFocusOn: 2.2, forDuration: 1.5) })
        let wander = entityManager.loadWander(messages: ["Hi", "Have you seen the donuts?","There are four of them"], loopOn: 3)!
        waitAndRun(delay: 5, function: { () in self.updateStoryText(with: "...", around: wander, timeToFocusOn: 2, forDuration: 1) })
        waitAndRun(delay: 7, function: { () in self.updateStoryText(with: "Explore and interact", around: self.playerNode!, displayIn: 0.5, fadeOut: 0.5, timeToFocusOn: 2) })


        //      FEEDBACK SETUP
        var touchF: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        touchF[bitmasks.wander] = ["Find the big boi", "Only he got the knowledge", "Don't touch me alright?"]
        touchF[bitmasks.storyTeller] = ["Wassap", "Oh yeah get as low as you can", "Did you find it?", "Go lower"]

        var hintF: Dictionary<GKEntity, [String]> = Dictionary<GKEntity, [String]>()
        hintF[wander.entity!] = ["What are those creatures"]
        hintF[storyTeller!] = ["That big guy got some secrets"]

        let feedback = FeedbackComponent(feedbackHint: hintF, feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)

//        DIALOG SETUP
        dialogController = DialogController(gameScene: self, dialog1TextAndID: ("Eat it", 1), dialog2TextAndID: ("Push it", 2))
        corners.shuffle()
        spawnDecoyDonut(cornerNum: 0)
        spawnDecoyDonut(cornerNum: 1)
        spawnDecoyDonut(cornerNum: 2)
        spawnDonut()
    }

    private func spawnDecoyDonut(cornerNum: Int) {
        let d = Collectible(texture: "donut", size: CGSize(width: 70, height: 70), id: String(-cornerNum), protectable: false, entityManager: entityManager, location: corners[cornerNum])
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
        donut = Collectible(texture: "donut", size: CGSize(width: 70, height: 70), id: "1", protectable: false, entityManager: entityManager, location: corners[3])
        if let node = donut?.spriteComp.node {
            node.zPosition = 5
            node.run(SKAction.repeatForever(.sequence([.wait(forDuration: 0.5), SKAction.run({ () in node.run(SKAction.applyImpulse(CGVector(dx: Int.random(in: -20...20), dy: Int.random(in: -20...20)), duration: 0.3)) })])))
        }
        entityManager.add(entity: donut!)
    }

    override func nextLevel() {
        changingLevel = true
        print("loading next level")
        if let scene = SKScene(fileNamed: "Level1_2") {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: "Level1_2")
            self.view?.presentScene(scene)
        }
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        let player: SKPhysicsBody
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyA
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyB
            otherNode = contact.bodyA
        } else {
            return
        }
        if let entity = otherNode.node?.entity {
            saveFeedback(feedback: (entityManager.player?.component(ofType: FeedbackComponent.self)?.giveFeedbackHint(on: entity))!)
        }
//        DIALOG RESOLUTIONS
//        1. PINK DONUT IS EATEN
//        2. PINK DONUT IS PUSHED
//        3. GREEN DONUT IS EATEN
//        4. GREEN DONUT IS PUSHED
        if !(dialogController?.active ?? false) && otherNode.node != lastTouched && dialogController?.finished ?? false {
            if (dialogStoryResolution ?? 0) == 2 || (dialogStoryResolution ?? 0) == 4 && otherNode.node?.name == "-2" {
                dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 3), dialog2TextAndID: ("Push it", 4))
            } else {
                dialogController?.setUpNewDialogs(dialog1TextAndID: ("Eat it", 1), dialog2TextAndID: ("Push it", 2))
            }
        }
        if !(dialogController?.active ?? false) && otherNode.categoryBitMask == bitmasks.collectible.rawValue, !(dialogController?.finished ?? false) {
            if  otherNode.node?.name == "1" || (dialogStoryResolution ?? 0) == 2 && otherNode.node?.name == "-2" {
                wasStoryDialog = true
                disableMovement()
                dialogController?.showDialog(parentNode: camera!);
            } else {
                wasStoryDialog = false
                disableMovement()
                dialogController?.showDialog(parentNode: camera!);
            }
        }
        lastTouched = otherNode.node
        super.didBegin(contact)
    }

    private func applyPenalty(nodeCausedThis: String?) {
        switch nodeCausedThis {
        case "0":
            playerNode?.run(SKAction.repeat(.sequence([.wait(forDuration: 0.5), SKAction.run({ () in self.playerNode?.run(SKAction.applyImpulse(CGVector(dx: Int.random(in: -10...10), dy: Int.random(in: -10...10)), duration: 0.3)) })]), count: 50))
        case "-1":
            gameOver()
        case "-2":
            warpAnimation(position: playerNode?.position ?? CGPoint(x: 5000, y: 5000))
            if donut?.collected ?? false {
                nextLevel()
            }
            playerNode?.run(.colorize(with: .green, colorBlendFactor: 0.9, duration: 1))
        default:
            playerNode?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.9, duration: 1))
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!(dialogController?.finished ?? false)) {
            if (wasStoryDialog) {
                dialogStoryResolution = dialogController?.dialogResolution(touches: touches, touchedIn: camera!)
                if dialogStoryResolution != nil {
                    enableMovement()
                    if dialogStoryResolution! == 1 {
//                        DONUT IS COLLECTED
                        print("collected - player way")
                        donut?.collect()
                        storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story: ["Hey you ate it!", "Alright then find yourself a way out"])
                    } else if dialogStoryResolution! == 2 {
//                        DONUT IS REMOVED NOT COLLECTED
                        print("will be removed - story")
                        storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story:
                        ["Oh my gaaawd yes", "Now you need to find and eat green donut, then come back to me."],
                                completion: { () in
                                    if self.donut != nil {
                                        self.entityManager.remove(entity: self.donut!)
                                    }
                                })
                    } else if dialogStoryResolution! == 4 {
                        storyTeller?.component(ofType: StoryComponent.self)?.addAnotherStory(story:
                        ["You made it", "So you know, you have to go as to the bottom,\n that's your direction take care and eat some donuts!"],
                                completion: { () in (self.entityManager.findEntity(entityNodeName: "-2") as? Collectible)?.collect() })
                        playerNode?.run(SKAction.sequence([.applyImpulse(CGVector(dx: 0, dy: -500), duration: 1), .wait(forDuration: 1), SKAction.run({ () in self.nextLevel() })]))
                    }
                }
            } else {
                dialogResolution = dialogController?.dialogResolution(touches: touches, touchedIn: camera!)
                if dialogResolution != nil {
                    enableMovement()
                    if dialogResolution! == 1 {
                        switch lastTouched?.name {
                        case "0":
                            (entityManager.findEntity(entityNodeName: "0") as? Collectible)?.collect()
                            applyPenalty(nodeCausedThis: "0")
                        case "-1":
                            (entityManager.findEntity(entityNodeName: "-1") as? Collectible)?.collect()
                            applyPenalty(nodeCausedThis: "-1")
                        case "-2":
                            dialogStoryResolution = 3
                            (entityManager.findEntity(entityNodeName: "-2") as? Collectible)?.collect()
                            applyPenalty(nodeCausedThis: "-2")
                        case .none: break
                        case .some(_): break
                        }
                    }
                }
            }
        }
        super.touchesBegan(touches, with: event)
    }
}
