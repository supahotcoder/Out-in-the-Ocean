//
//  Level1-2.swift
//
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
        playerSpawnPosition = CGPoint(x: -2880.0, y: 320.0)
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level1-2")
//      SETTING UP MAZE
        boundaries = StaticBackground(imageName: "boundaries1_2", entityManager: entityManager)
        boundaries?.spriteComp.node.zPosition = 4
        boundaries?.spriteComp.node.position = CGPoint(x: 0, y: 0)
        entityManager.add(entity: boundaries!)

//     INITIAL MESSAGES
        self.updateStoryText(with: "I should find a way out.", around: self.playerNode!, fadeOut: 0.5)
        self.updateGoalText(with: "Trying to be still in some stressful situations might be a good idea", around: self.playerNode!, displayIn: 2)

//       LOADING EXIT LEVEL WARPER
        endLevelWarper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        let warper = endLevelWarper!.component(ofType: SpriteComponent.self)!.node
        warper.zPosition = 4
        warper.run(SKAction.rotate(byAngle: 90, duration: 600))
        warper.position = CGPoint(x: 2840, y: -320)
        self.addChild(warper)

//       LOADING SEARCHERs
        let searcher1 = entityManager.loadSearcher(positionTo: CGPoint(x: -2880, y: -320), imageNamed: "evil_player1")
        searcher1?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher1?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

        let searcher2 = entityManager.loadSearcher(positionTo: CGPoint(x: -320, y: -640), imageNamed: "evil_player1")
        searcher2?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher2?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

        let searcher3 = entityManager.loadSearcher(positionTo: CGPoint(x: 2400, y: 320), imageNamed: "evil_player1")
        searcher3?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
        searcher3?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue

//        BACKGROUND SOUND SETTING
        backgroundMusic(fileName: "level1-2-sound", extension: "wav")
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
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
        let nextlevel = "Level1_2S"
        if let scene = SKScene(fileNamed: nextlevel) {
            self.removeAllActions()
            self.removeAllChildren()
            saveLevel(levelName: nextlevel)
            self.view?.presentScene(scene)
        }
    }
}

