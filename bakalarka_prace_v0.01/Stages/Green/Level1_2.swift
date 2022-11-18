//
//  Level1-2.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 26/04/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class Level1_2: Level1 {

    var boundaries: StaticBackground?
    var endLevelWarper: ActiveBackground?


    override func didMove(to view: SKView) {
        self.background = childNode(withName: "background1_2") as? SKSpriteNode
        self.name = "Level1_2"
        super.didMove(to: view)
        playerNode?.position = CGPoint(x: -2880.0, y: 320.0)

//      SETTING UP MAZE
        boundaries = StaticBackground(imageName: "boundaries1_2", entityManager: entityManager)
        boundaries?.spriteComp.node.zPosition = 4
        boundaries?.spriteComp.node.position = CGPoint(x: 0, y: 0)
        entityManager.add(entity: boundaries!)

//     INITIAL MESSAGES
        waitAndRun(delay: 1, function: { () in self.updateStoryText(with: "Find a way out!", around: self.playerNode!, displayIn: 0.2, fadeOut: 0.5, timeToFocusOn: 3) })
        waitAndRun(delay: 3, function: { () in self.updateStoryText(with: "Stay put and try to chill out through this passage", around: self.playerNode!, displayIn: 0.5, fadeOut: 1, timeToFocusOn: 3) })
        waitAndRun(delay: 7, function: { () in self.updateGoalText(with: "Hey pshhh", around: self.playerNode!) })
        waitAndRun(delay: 9, function: { () in self.updateGoalText(with: "Being still is what you looking for \n in some stressful situations", around: self.playerNode!) })

//       LOADING EXIT LEVEL WARPER
        endLevelWarper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        let warper = endLevelWarper!.component(ofType: SpriteComponent.self)!.node
        warper.zPosition = 4
        warper.run(SKAction.rotate(byAngle: 90, duration: 600))
        warper.position = CGPoint(x: 2840, y: -320)
        self.addChild(warper)

//       LOADING SEARCHERs
        let searcher1 = entityManager.loadSearcher(positionTo: CGPoint(x: -2880, y: -320))
        searcher1?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher1?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

        let searcher2 = entityManager.loadSearcher(positionTo: CGPoint(x: -320, y: -640))
        searcher2?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher2?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

        let searcher3 = entityManager.loadSearcher(positionTo: CGPoint(x: 2400, y: 320))
        searcher3?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher3?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

//        BACKGROUND SOUND SETTING
        backgroundMusic(fileName: "level1-2-sound", extension: "wav")
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
        if endLevelWarper == otherNode.node?.entity {
            nextLevel()
        }
        if otherNode.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        }
        super.didBegin(contact)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override func nextLevel() {
        changingLevel = true
        if let scene = SKScene(fileNamed: "Level1_3") {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: "Level1_2")
            self.view?.presentScene(scene)
        }
    }
}

