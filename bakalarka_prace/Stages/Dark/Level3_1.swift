//
//  Level3_1.swift
//  bakalarka_prace_v0.01
//

//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level3_1: GameScene{

    private var warperNode: SKSpriteNode!
    private var slimeNode: SKSpriteNode!

    private var lastTimeWarperTp: Date = Date()
    private var lastTimeSlimeTp: Date = Date()

    override func didMove(to view: SKView) {
        self.name = "Level3_1"
        //MUSIC SETUP
        backgroundMusic(fileName: "level3-1-sound", extension: "wav")
        // BACKGROUND BOUNDARY
        background = childNode(withName: "background") as? SKSpriteNode
        physicsBody = SKPhysicsBody(edgeLoopFrom: background!.frame)
        physicsBody?.categoryBitMask = bitmasks.frame.rawValue
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: 0, y: 0)
        // Interdimensional effect
        let frontEffect = SKEmitterNode(fileNamed: "InterdimensionalEffect")!

        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        frontEffect.particlePositionRange = backgroundRange

        frontEffect.position = CGPoint(x: 0, y: 0)
        frontEffect.zPosition = 3
        self.addChild(frontEffect)
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level3-1")
        updateStoryText(with: "All right let's do it", around: playerNode!)

        // WANDERS (DEADLY)
//        entityManager.loadWander(imageName: "cupcakeus", position: CGPoint(x: -400, y: 680))
//        entityManager.loadWander(imageName: "cupcakeus", position: CGPoint(x: -400, y: -680))
        let deadlyMessages = ["Come closer little one","Touch me and I'll give you all the answers","I'll tell you a strategy how to find a crystal key\n...just come little closer","Don't be scared of me I won't bite!","Touch me I'll teleport you to the place you want to be","Don't trust all the guys I have the key, touch me!","I just need a hug","It's so lonely in here always the same people.\nCome talk to me","My vision is kinda bad, kindly come closer to me","When you bump to me you can teleport","Always shook hands with someone you've just met!"]
        entityManager.loadWander(messages: deadlyMessages,imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)
        entityManager.loadWander(messages: deadlyMessages.shuffled(),imageName: "cupcakeus", position: CGPoint.randomPositionAvoidNode(x: -400...400, y: -630...630, nodeToAvoid: playerNode!),rotation: 0)

        // WARPER SETUP
        let warper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        warper.component(ofType: SpriteComponent.self)?.node.zPosition = 3
        warperNode = warper.component(ofType: SpriteComponent.self)!.node
        warperNode.position = CGPoint(x: 440, y: 400)
        warperNode.run(SKAction.rotate(byAngle: 90, duration: 600))
        self.addChild(warperNode)
        // SLIME SETUP
        slimeNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "slime", triggerable: true, position: CGPoint(x: -600, y: -600), rotation: CGFloat(0)).node
    }

    @discardableResult
    func warpAnimation(position: CGPoint, warpFile: String = "Warping") -> SKEmitterNode {
        let warp = SKEmitterNode(fileNamed: warpFile)!
        let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
        warp.position = position
        warp.zPosition = 3
        self.addChild(warp)
        warp.run(removeWarp)
        return warp
    }

    func warp(contact: SKPhysicsContact, otherNode: SKNode?, teleportTo: CGPoint? = nil) {
        if otherNode != nil {
            warpAnimation(position: contact.contactPoint,warpFile: "Warp2")
            var destination = CGPoint.randomPositionAvoidNode(x: -640...640, y: -640...640, nodeToAvoid: playerNode!)
            if let tpTo = teleportTo {
                destination = tpTo
            }
            // první se vynoří animace a až za 1.5s teleportovaný objekt
            teleport(pos: destination, otherNode: otherNode)
            if otherNode != warperNode{
                teleport(pos: CGPoint.randomPositionAvoidNode(x: -640...640, y: -640...640, nodeToAvoid: playerNode!), otherNode: warperNode, isWarper: true)
            }
        }
    }

    private func teleport(pos: CGPoint, otherNode: SKNode?, isWarper: Bool = false) {
        warpAnimation(position: pos)
        if otherNode?.physicsBody?.categoryBitMask != bitmasks.player.rawValue {
            var void = CGPoint(x: 5000, y: 5000)
            var reappearingTime = 1.5
            if isWarper{
                void = CGPoint.randomPosition(x: -5000...(-4000), y: -5000...(-4000))
                reappearingTime = 2.5
            }
            let teleport = SKAction.sequence([SKAction.customAction(withDuration: 0) { node, _ in node.position = void }, SKAction.wait(forDuration: reappearingTime), SKAction.customAction(withDuration: 0) { node, _ in node.position = pos }])
            otherNode?.run(teleport)
        } else {
            playerNode?.run(SKAction.customAction(withDuration: 0) { node, _ in node.position = pos })
        }
    }

    func gameOver() {
        GameSceneClass.haveDied = true
        playerNode?.physicsBody?.categoryBitMask = 0b0
        playerNode?.physicsBody?.contactTestBitMask = 0b0
        playerNode?.physicsBody?.collisionBitMask = 0b0
        playerNode?.run(SKAction.fadeOut(withDuration: 2))
        let end = SKEmitterNode(fileNamed: "Ending2")!
        end.position = (playerNode?.position)!
        end.zPosition = 6
        self.addChild(end)
        let seconds = CGFloat(end.numParticlesToEmit) / end.particleBirthRate + end.particleLifetime + end.particleLifetimeRange / 3
        self.scene?.run(SKAction.fadeOut(withDuration: TimeInterval(seconds)))
        //zrušení pohybu a zpráv
        joystickNode?.removeFromParent()
        entityManager.gameOver = true
        //přepnutí scény po End scene
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(seconds)) {
            if let scene = SKScene(fileNamed: self.name!) {
                self.removeAllActions()
                self.removeAllChildren()
                self.view?.presentScene(scene)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        }
        // WARPER CONTACT
        else if contact.bodyB.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue || contact.bodyB.node?.physicsBody?.categoryBitMask == bitmasks.frame.rawValue {
            warp(contact: contact, otherNode: contact.bodyA.node)
            return
        } else if contact.bodyA.node?.physicsBody?.categoryBitMask == bitmasks.activeBackground.rawValue || contact.bodyA.node?.physicsBody?.categoryBitMask == bitmasks.frame.rawValue{
            warp(contact: contact, otherNode: contact.bodyB.node)
            return
        } else {
            return
        }
        // PLAYER INTERACTION ONLY
        if otherNode.categoryBitMask == bitmasks.wander.rawValue {
            gameOver()
        } else if otherNode.categoryBitMask == bitmasks.frame.rawValue {
            teleport(pos: CGPoint.randomPositionAvoidNode(x: -640...640, y: -640...640, nodeToAvoid: slimeNode), otherNode: playerNode!)
        }else if otherNode.categoryBitMask == bitmasks.activeBackground.rawValue {
            warp(contact: contact, otherNode: playerNode!)
        }else if otherNode.categoryBitMask == bitmasks.storyTeller.rawValue {
            nextLevel()
        }
    }

    func nextLevel(){
        changingLevel = true
        playerNode?.physicsBody?.categoryBitMask = 0b0
        playerNode?.physicsBody?.contactTestBitMask = 0b0
        playerNode?.physicsBody?.collisionBitMask = 0b0
        let nextlevel = "Level4_1"
            joystickNode?.removeAllChildren()
            joystickNode?.removeFromParent()
            playerNode?.removeAllActions()
            saveLevel(levelName: nextlevel)
            let warp = SKEmitterNode(fileNamed: "Warp2")!
            let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent()])
            warp.position = playerNode!.position
            warp.zPosition = 2
            self.addChild(warp)
            warp.run(removeWarp)
            self.playerNode?.run(SKAction.fadeOut(withDuration: 1))
            self.scene?.run(SKAction.colorize(with: UIColor.init(red: 90 / 255, green: 50 / 255, blue: 120 / 255, alpha: 1), colorBlendFactor: 0.9, duration: 3))
            waitAndRun(delay: 2, function: { () in
                self.scene?.run(SKAction.fadeOut(withDuration: 1), completion: {
                    if let scene = SKScene(fileNamed: nextlevel) {
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(scene)
                    }
                })
            })
    }

    override func update(_ currentTime: TimeInterval) {
        if -lastTimeWarperTp.timeIntervalSinceNow > 6{
            teleport(pos: CGPoint.randomPositionAvoidNode(x: -640...640, y: -640...640, nodeToAvoid: playerNode!), otherNode: warperNode)
            lastTimeWarperTp = Date()
        }
        if -lastTimeSlimeTp.timeIntervalSinceNow > 8{
            teleport(pos: CGPoint.randomPositionAvoidNode(x: -640...640, y: -640...640, nodeToAvoid: playerNode!, xBodySizesFromNode: 4), otherNode: slimeNode)
            lastTimeSlimeTp = Date()
        }

        super.update(currentTime)
    }
}
