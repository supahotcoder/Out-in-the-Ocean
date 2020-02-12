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
    
    override func didMove(to view: SKView) {
        // LEVEL FUNCTIONALITY
        self.background = childNode(withName: "pozadi") as? SKSpriteNode
        self.name = "Level1_1"
        super.didMove(to: view)
        playerNode?.position = CGPoint(x: 150.0,y: 320.0)
        // TODO: - override name, background, start point, etc.
        #warning("Level1_1 setup missing")

        // STORYTELLER SETUP
        let storyToTell = ["Teeest","Teeeest1","TEeeeST3"]
        let storyTeller = entityManager.loadStoryTeller(storyToTell: storyToTell)!

        updateStoryText(with: "Biiiioiiiiiiiig test", around: storyTeller)

        // WANDER SETUP
        updateStoryText(with: "Find out what is this realm about\n", around: entityManager.loadWander()!, displayIn: 2)
        let msgs = ["Hi" , "...",]
        let warning = ["Get out", "Beware","Watch out", "Booo"]

        let wander = entityManager.loadWander(messages: msgs, loopOn: 3, warningMsgs: warning)!

        updateStoryText(with: "Testing ", around: wander, displayIn: 2)

        //      FEEDBACK SETUP
//        TODO: - zamyslet se nad novymi vecmi co pridat do programming casti, jinak vytvorit dalsi urven

        var touchF: Dictionary<bitmasks,[String]> = Dictionary<bitmasks,[String]>()
        touchF[bitmasks.wander] = ["Test1_WANDER", "Test2_WANDER"]
        touchF[bitmasks.storyTeller] = ["Test1_BT", "Test2_BT"]

        var hintF: Dictionary<GKEntity,[String]> = Dictionary<GKEntity,[String]>()
        hintF[wander.entity!] = ["Test hint wander"]
        hintF[storyTeller.entity!] = ["Test hint storyteller"]

        let feedback = FeedbackComponent(feedbackHint: hintF, feedbackTouch: touchF)
        entityManager.addComponentToPlayer(component: feedback)

    }
    
    override func nextLevel() {
        if let scene = SKScene(fileNamed: "Level1_3") {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: "Level1_3")
            self.view?.presentScene(scene)
        }
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
            else{
            return
        }
            if let entity = otherNode.node?.entity {
                saveFeedback(feedback: (entityManager.player?.component(ofType: FeedbackComponent.self)!.giveFeedbackHint(on: entity))!)
        }
        super.didBegin(contact)
    }
}
