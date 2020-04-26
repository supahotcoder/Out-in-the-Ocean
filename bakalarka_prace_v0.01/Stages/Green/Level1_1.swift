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
        let storyToTell = ["Hello there am I supposed to tell you some wisdom?","Oh so you assume that, because that I have a huge eye ?!","You better watch yourself,\n your only luck is that these green waters are stupid friendly", "Get out of my face already"]
        let storyTeller = entityManager.loadStoryTeller(storyToTell: storyToTell)!

        updateStoryText(with: "I ain't that big though", around: storyTeller,timeToFocusOn: 3.3, forDuration: 2)

        // WANDER SETUP
        waitAndRun(delay: 3, function: {() in self.updateStoryText(with: "Find out what is this realm about", around: self.entityManager.loadWander()!,timeToFocusOn: 2.2, forDuration: 1.5)})
        
        let msgs = ["Hi" , "...",]
        let warning = ["Get out", "Beware","Watch out", "Booo"]

        let wander = entityManager.loadWander(messages: msgs, loopOn: 3, warningMsgs: warning)!

        waitAndRun(delay: 5, function:{() in self.updateStoryText(with: "...", around: wander,timeToFocusOn: 2, forDuration: 1)})

        //      FEEDBACK SETUP

        var touchF: Dictionary<bitmasks,[String]> = Dictionary<bitmasks,[String]>()
        touchF[bitmasks.wander] = ["Find the big boi", "Only he got the knowledge"]
        touchF[bitmasks.storyTeller] = ["Wassap", "Oh yeah get as low as you can", "Did you find it?", "Go lower"]

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
