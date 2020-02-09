//
//  Level1_3.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 04/04/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Level1_3: Level1 {

    var c1 : Collectible!
    var c2 : Collectible!
    var c3 : Collectible!
    var c4 : Collectible!

//    TODO: FEEDBACK COMP BUDE MIT JAKYSI ZAASOBNIK  A UKLADAT SE NEAJK PODLE PRIORIT NEBO PODLE POSLEDNIHO S CIM MEL CO DOCINENI
//          TEORETICKY PAK PO SMRTI BUD BUDE RIKAT VIC VECI NEBO JENOM JEDEN A KDYZ NIC DALSIHO NEBUDE MIT TAK ZE ZASOBNIKU HODI NECO
    
    override func didMove(to view: SKView) {
        //LEVEL FUNCTIONALITY
        self.background = childNode(withName: "pozadi") as? SKSpriteNode
        self.name = "Level1_3"
        super.didMove(to: view)

        //SEARCHER SETUP
        let searcher = entityManager.loadSearcher()
        entityManager.loadSearcher()
        // SPINNER SETUP
        let warper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        warperNode = warper.component(ofType: SpriteComponent.self)!.node
        warperNode.run(SKAction.rotate(byAngle: 90, duration: 300))
        self.addChild(warperNode)
        
        //TEXT SETUP
        updateStoryText(with: "Okay let's find out what's this about", around: playerNode!,displayIn: 0, fadeOut: 1, timeToFocusOn: 4)

        if (!GameSceneClass.haveDied) {
            updateGoalText(with: "Watch the environment\n and yourself especially", around: playerNode!)
        }
        //TEXTMSGS SETUP
        //TODO: - TODO: ADD Text file story strings
        
        //WANDER SETUP
        let msgs = ["Hi" , "...", "Hello stranger" ,"It's getting greener", "Welcome Traveler",
                    "Something,\n is not right in there" ,"Not me", "Did you found\n what you've been looking for?", "Don't bother me"]
        let warning = ["Get out", "Beware","Watch out", "Booo"]
        let wander = entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 0, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 2, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 4, warningMsgs: warning)
        //MUSIC SETUP
        backgroundMusic(fileName: "level1_back_sound", extension: "wav")
        
        
        //TESTING - HUE EFFECT for collectible later
        effectNode.shouldRasterize = true
        playerNode?.removeFromParent()
        effectNode.zPosition = 3
        effectNode.addChild(playerNode!)
        effectNode.shouldEnableEffects = true
        self.addChild(effectNode)
        
        //TESTING - spawning collectible and that effect
        #warning("searcher protect collectible")
        // nízké hodnoty zvětšení pro rozeznání
        c1 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c1",protectable: true,entityManager: entityManager)
        c2 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c2",protectable: true,entityManager: entityManager)
        c3 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c3",protectable: true,entityManager: entityManager)
        c4 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c4",protectable: true,entityManager: entityManager)
        
        entityManager.add(entity: c1)
        entityManager.add(entity: c2)
        entityManager.add(entity: c3)
        entityManager.add(entity: c4)

        var touchF: Dictionary<bitmasks,[String]> = Dictionary<bitmasks,[String]>()
        touchF[bitmasks.collectible] = ["Mmmm donuts...", "Yummy", "My tummy feels weird", "Feeling bit dizzy"]
        touchF[bitmasks.wander] = ["Ouch", "Ah, sorry", "Hey", "Watch out you ... thing"]
        touchF[bitmasks.activeBackground] = ["What just happened", "Did we just...?", "That was confusing"]

        var hintF: Dictionary<GKEntity,[String]> = Dictionary<GKEntity,[String]>()
        hintF[wander!.entity!] = ["Are those three eyed creatures\n trying to say something?", "Hmm those creatures really create mood"]
        hintF[searcher!.entity!] = ["I should avoid that green ball", "I got poisoned, rather avoid that next time"]
        hintF[c1] = ["I felt different after eating those donuts", "Let's get some more donuts","Those donuts are really good","I'm getting addicted on the donuts"]
        hintF[warperNode.entity!] = ["Did I just teleported","This is gotta be it, this is my way out","I need to use that teleporty thing"]
        let feedback = FeedbackComponent(feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        let player : SKPhysicsBody
        let otherNode : SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyA
            otherNode = contact.bodyB
        }
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            player = contact.bodyB
            otherNode = contact.bodyA
        }
        // WARPER CONTACT
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            warp(contact: contact,otherNode: contact.bodyA.node)
            return
        }
        else if contact.bodyA.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue{
            warp(contact: contact,otherNode: contact.bodyB.node)
            return
        }
        else {
            return
        }
        // PLAYER INTERACTION ONLY
        if otherNode.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        }
        else if otherNode.categoryBitMask == bitmasks.activeBackground.rawValue{
            //NOTICE: - Due to some unexplainable bug otherNode.node?.position
            //          would return (NaN,NaN), that's why is contactPoint is used instead
            print(collectibleCount)
            if collectibleCount < 3{
                warp(contact: contact, otherNode: playerNode)
                return
            }
            else if collectibleCount == 3{
                nextLevel()
                return
            }
            else {
                playerNode?.physicsBody?.applyImpulse(-(playerNode?.physicsBody?.velocity)!)
            }
            
        }
        else if otherNode.categoryBitMask == bitmasks.collectible.rawValue {
            // preparing for the warp
            if collectibleCount == 2{
                playerNode?.run(SKAction.colorize(with: .green, colorBlendFactor: 0.9, duration: 3))
                effectNode.filter = CIFilter(name: "CITorusLensDistortion", parameters: ["inputRadius": 20,"inputRefraction": 3])
            }
            else{
                playerNode?.run(SKAction.colorize(with: UIColor(red: CGFloat(200 - collectibleCount * 200) / 255, green: CGFloat(0 + collectibleCount * 200) / 255, blue: CGFloat(200 - collectibleCount * 200) / 255, alpha: 1), colorBlendFactor: 1, duration: 3))
            }

            switch otherNode.node?.name{
            case "c1": entityManager.remove(entity: c1)
            case "c2": entityManager.remove(entity: c2)
            case "c3": entityManager.remove(entity: c3)
            case "c4": entityManager.remove(entity: c4)
            default:
                break
            }
            collectibleCount += 1
        }
        super.didBegin(contact)
    }

    override func nextLevel() {
        if let scene = SKScene(fileNamed: "Level2") {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: "Level2")
            self.view?.presentScene(scene)
        }
    }
}
