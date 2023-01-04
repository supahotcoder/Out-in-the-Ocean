//
//  Level1_3.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Level1_3: Level1 {

    var c1: Collectible!
    var c2: Collectible!
    var c3: Collectible!
    var c4: Collectible!

    override func didMove(to view: SKView) {
        //LEVEL FUNCTIONALITY
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.name = "Level1_3"
        super.didMove(to: view)
        //MUSIC SETUP
        backgroundMusic(fileName: "level1-3-sound", extension: "wav")
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level1-3")
        //SEARCHER SETUP
        let searcher = entityManager.loadSearcher(imageNamed: "evil_player1")
        entityManager.loadSearcher(imageNamed: "evil_player1")
        // WARPER SETUP
        let warper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        warper.component(ofType: SpriteComponent.self)?.node.zPosition = 3
        warperNode = warper.component(ofType: SpriteComponent.self)!.node
        warperNode.run(SKAction.rotate(byAngle: 90, duration: 600))
        self.addChild(warperNode)

        // TEXT SETUP
        updateStoryText(with: "Okay let's see.", around: playerNode!, displayIn: 0, fadeOut: 1, forDuration: 2)

        if (!GameSceneClass.haveDied) {
            updateGoalText(with: "Maybe I should watch the environment\nand myself especially", around: playerNode!)
            updateGoalText(with: "My body is my temple...but few donuts...could be nice", around: playerNode!)
        }
        //WANDER SETUP
        let msgs = ["Hi", "...", "Hello stranger", "It's getting greener", "Welcome Traveler",
                    "Something,\nis not right in there", "Not me", "Did you found\nwhat you've been looking for?", "Don't bother me"]
        let warning = ["Get out!", "Beware!", "Watch out!", "They are coming!","Oh no, they are close!","Don't move!"]
        let wander = entityManager.loadWander(messages: msgs, warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(messages: msgs, warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(messages: msgs, warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(messages: [msgs[0]], warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(messages: Array(msgs.prefix(2)), warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))
        entityManager.loadWander(messages: Array(msgs.prefix(3)), warningMsgs: warning, position: CGPoint.randomPosition(x: -840...840, y: -640...640))

        //HUE EFFECT for collectible
        effectNode.shouldRasterize = true
        playerNode?.removeFromParent()
        effectNode.zPosition = 3
        effectNode.addChild(playerNode!)
        effectNode.shouldEnableEffects = true
        self.addChild(effectNode)

//      SETUP COLLECTIBLE
        c1 = Collectible(imageNamed: "donut", size: BodyPathsBodySizes.getBodySize(textureName: "donut"), id: "c1", protectable: true, entityManager: entityManager)
        c2 = Collectible(imageNamed: "donut", size: BodyPathsBodySizes.getBodySize(textureName: "donut"), id: "c2", protectable: true, entityManager: entityManager)
        c3 = Collectible(imageNamed: "donut", size: BodyPathsBodySizes.getBodySize(textureName: "donut"), id: "c3", protectable: true, entityManager: entityManager)
        c4 = Collectible(imageNamed: "donut", size: BodyPathsBodySizes.getBodySize(textureName: "donut"), id: "c4", protectable: true, entityManager: entityManager)

        c1.spriteComp.node.zPosition = 3
        c2.spriteComp.node.zPosition = 3
        c3.spriteComp.node.zPosition = 3
        c4.spriteComp.node.zPosition = 3

        entityManager.add(entity: c1)
        entityManager.add(entity: c2)
        entityManager.add(entity: c3)
        entityManager.add(entity: c4)

        var touchF: Dictionary<bitmasks, [String]> = Dictionary<bitmasks, [String]>()
        touchF[bitmasks.collectible] = ["Mmmm donuts...", "Yummy", "My tummy feels weird", "Feeling bit dizzy"]
        touchF[bitmasks.wander] = ["Ouch", "Ah, sorry", "Hey", "Watch out you ... thing"]
        touchF[bitmasks.activeBackground] = ["What did just happened?", "Did we just...?", "That was confusing"]

        var hintF: Dictionary<GKEntity, [String]> = Dictionary<GKEntity, [String]>()
        hintF[wander!.entity!] = ["Are those three eyed creatures\ntrying to say something?"]
        hintF[searcher!.entity!] = ["I should avoid that green ball", "I got poisoned, rather avoid that next time"]
        hintF[c1] = ["I felt different after eating those donuts", "Let's get some more donuts", "Those donuts are really good", "I'm getting addicted on the donuts"]
        hintF[warperNode.entity!] = ["Did I just teleported", "This is gotta be it, this is my way out", "I need to use that warper"]
        let feedback = FeedbackComponent(feedbackHint: hintF, feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        }
        // WARPER CONTACT
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue {
            warp(contact: contact, otherNode: contact.bodyA.node)
            return
        } else if contact.bodyA.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue {
            warp(contact: contact, otherNode: contact.bodyB.node)
            return
        } else {
            return
        }
        // PLAYER INTERACTION ONLY
        if otherNode.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        } else if otherNode.categoryBitMask == bitmasks.activeBackground.rawValue {
            //NOTICE: - Due to some unexplainable bug otherNode.node?.position
            //          would return (NaN,NaN), that's why is contactPoint is used instead
            print(collectibleCount)
            if collectibleCount < 3 {
                warp(contact: contact, otherNode: playerNode)
                return
            } else if collectibleCount == 3 {
                nextLevel()
                return
            } else {
                playerNode?.physicsBody?.applyImpulse(-(playerNode?.physicsBody?.velocity)!)
            }

        } else if otherNode.categoryBitMask == bitmasks.collectible.rawValue {
            // priprava pro warpovani (meni se vizual hrace, to by ho melo prijmet uvazovat na co se zacina podobat)
            if collectibleCount == 2 {
                playerNode?.run(SKAction.colorize(with: .green, colorBlendFactor: 0.9, duration: 3))
                effectNode.filter = CIFilter(name: "CITorusLensDistortion", parameters: ["inputRadius": 20, "inputRefraction": 3])
            } else if collectibleCount > 2{
                gameOver()
            } else {
                playerNode?.run(SKAction.colorize(with: UIColor(red: CGFloat(200 - collectibleCount * 200) / 255, green: CGFloat(0 + collectibleCount * 200) / 255, blue: CGFloat(200 - collectibleCount * 200) / 255, alpha: 1), colorBlendFactor: 1, duration: 3))
            }
            switch otherNode.node?.name {
            case "c1": c1.collect()
            case "c2": c2.collect()
            case "c3": c3.collect()
            case "c4": c4.collect()
            default:
                break
            }
            collectibleCount += 1
        }
        super.didBegin(contact)
    }

    override func nextLevel() {
        changingLevel = true
        let nextlevel = "Level2_1S"
        saveLevel(levelName: nextlevel)
        if let scene = SKScene(fileNamed: nextlevel) {
            self.removeAllActions()
            self.removeAllChildren()
            self.view?.presentScene(scene)
        }
    }
}
