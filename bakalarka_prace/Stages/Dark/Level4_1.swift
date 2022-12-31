//
//  Level4_1.swift
//  bakalarka_prace_v0.01
//

//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Level4_1: GameScene{

    private var timePassed: Date = Date()

    private var changedMusic: Bool = false
    private var gameFinito: Bool = false
    private var playerChooseEnding: Bool = false
    private var reversoMovement: Bool = false

    private var startedFinalChapter: Bool = false

    private var reversoNode: SKSpriteNode!
    private var secretElement: Collectible!

    private var key1: Collectible!
    private var key2: Collectible!

    override func didMove(to view: SKView) {
        self.name = "Level4_1"
        //MUSIC SETUP
        backgroundMusic(fileName: "level4-1-sound", extension: "wav")
        // BACKGROUND BOUNDARY
        background = childNode(withName: "background") as? SKSpriteNode
        physicsBody = SKPhysicsBody(edgeLoopFrom: background!.frame)
        physicsBody?.categoryBitMask = bitmasks.frame.rawValue
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: -200, y: 0)

        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level4-1")
        // Smog effect
        let smogBack = SKEmitterNode(fileNamed: "SmogEffect")!
        let smogFront = SKEmitterNode(fileNamed: "SmogEffect")!
        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        smogBack.particlePositionRange = backgroundRange
        smogFront.particlePositionRange = backgroundRange

        smogBack.position = CGPoint(x: 0,y: 0)
        smogFront.position = CGPoint(x: 0,y: 0)
        smogFront.zPosition = 3
        self.addChild(smogFront)
        self.addChild(smogBack)
//      BOSS SETUP
        reversoNode = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "player_test", triggerable: false, position: CGPoint(x: 100, y: 0), rotation: CGFloat(1.7)).node
        reversoNode.run(.colorize(with: .white, colorBlendFactor: 1, duration: 0))
        reversoNode.run(.fadeIn(withDuration: 1))

        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        effectNode.shouldEnableEffects = true
        reversoNode.removeFromParent()
        effectNode.zPosition = 3
        effectNode.addChild(reversoNode)
        effectNode.filter = CIFilter(name: "CIColorControls", parameters: ["inputSaturation": 4 ,"inputBrightness": 0.2])
        self.addChild(effectNode)
//        SEARCHERS SETUP
        entityManager.loadSearcher(positionTo: CGPoint(x: 400, y: 550), imageNamed: "cupcakeus")
        entityManager.loadSearcher(positionTo: CGPoint(x: 400, y: 550), imageNamed: "cupcakeus")
        entityManager.loadSearcher(positionTo: CGPoint(x: -350, y: -600), imageNamed: "cupcakeus")
        entityManager.loadSearcher(positionTo: CGPoint(x: -350, y: -600), imageNamed: "cupcakeus")
//        COLLECTIBLE SETUP
        key1 = Collectible(imageNamed: "crystal-key", size: BodyPathsBodySizes.getBodySize(textureName: "crystal-key"), id: "1", protectable: false, entityManager: entityManager, location: CGPoint(x: 440, y: 600))
        key2 = Collectible(imageNamed: "crystal-key", size: BodyPathsBodySizes.getBodySize(textureName: "crystal-key"), id: "2", protectable: false, entityManager: entityManager, location: CGPoint(x: -400, y: -600))
        entityManager.add(entity: key1)
        entityManager.add(entity: key2)
//        ELEMENT SETUP
        let textureName = "crowner"
        secretElement = Collectible(imageNamed: textureName, size: BodyPathsBodySizes.getBodySize(textureName: textureName), id: "0", entityManager: entityManager, location: CGPoint(x: -360, y: -500))
        entityManager.add(entity: secretElement)
//        STORY TIME
        updateStoryText(with: "here in way your make you did how and ,you are who", around: reversoNode)
        updateStoryText(with: "accord own your on come you did or ,here you send someone did", around: reversoNode)
        updateStoryText(with: "you sent who !you not are ,force unifying the for here are you ,ahh", around: reversoNode)
        updateStoryText(with: "happens what matter no ,calm stay and move not do\nyou approach can I before thoroughly you test to have to going am I whatever", around: reversoNode)
        updateStoryText(with: "more no are and failed have many and\n,thing same the for looking ,you before come have many", around: reversoNode)
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
        } else {
            return
        }
        // PLAYER INTERACTION ONLY
        if otherNode.categoryBitMask == bitmasks.searcher.rawValue {
            gameOver()
        } else if otherNode.categoryBitMask == bitmasks.storyTeller.rawValue {
            gameOver()
        }else if otherNode.categoryBitMask == bitmasks.collectible.rawValue {
            print("Collecible")
            switch otherNode.node?.name {
            case "1":
                key1.collect()
            case "2":
                key2.collect()
            case "0":
                if key1.collected && key2.collected {
                    secretElement.collect()
                    finishGameByPlayer()
                }
            case .none:
                return
            case .some(_):
                return
            }
        }
    }

    private func showEnd(thanks: SKLabelNode) {
        changingLevel = true
        let nextlevel = "MainMenu"
        UserDefaults.standard.set(true, forKey: "finishedGame")
        UserDefaults.standard.synchronize()

        pauseGKEntities()
        let entities = entityManager.gameEntities
        entities.forEach { entity in
            if entity.component(ofType: PlayerComponent.self) == nil {
                entityManager.remove(entity: entity
                )
            }
        }
        self.removeAllActions()
        joystickNode?.removeAllChildren()
        joystickNode?.removeFromParent()
        pauseButton?.removeFromParent()

        saveLevel(levelName: nextlevel)

        let backColor = SKSpriteNode(color: .darkGray, size: CGSize(width: 3000, height: 3000))
        backColor.zPosition = 5
        backColor.run(.fadeOut(withDuration: 0))
        backColor.run(.fadeIn(withDuration: 3))
        addChild(backColor)

        camera?.removeAllActions()
        thanks.position = camera?.position ?? (playerNode?.position)!
        thanks.zPosition = 6
        thanks.numberOfLines = 3
        thanks.fontColor = UIColor.white
        thanks.fontSize = 25
        waitAndRun(delay: 2, function: {self.camera?.addChild(thanks)})
        waitAndRun(delay: 15, function: { () in
            if let menu = SKScene(fileNamed: nextlevel) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    menu.scaleMode = .resizeFill
                } else {
                    menu.scaleMode = .fill
                }
                self.playerNode?.run(SKAction.fadeOut(withDuration: 1), completion: {
                    self.scene?.run(SKAction.colorize(with: UIColor.init(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1), colorBlendFactor: 0.9, duration: 3))
                    self.scene?.run(SKAction.fadeOut(withDuration: 2.5), completion: {
                        self.stopAndRemoveMusic()
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(menu)
                    })
                })
            }
        })
    }

    func finishGameByPlayer(){
        let thanks = SKLabelNode(text: "Thank you for playing!\nYou have finished story by choosing to \"help\" your species.\nIn fact you just enslaved them\nBut hey, you did a great job!")
        showEnd(thanks: thanks)
    }

    func finishGame(){
        let thanks = SKLabelNode(text: "Thank you for playing!\nYou have finished story by listening to reverso.\nIn fact you might save the world\nI'm glad that you finished the game story.")
        showEnd(thanks: thanks)
    }

    override func update(_ currentTime: TimeInterval) {
        if !changedMusic && !gameFinito && playerNode?.physicsBody?.velocity.speed() ?? 0 > 0{
            stopAndRemoveMusic()
            backgroundMusic(fileName: "level4-1-player-way", extension: ".wav")
            changedMusic = true
            playerChooseEnding = true
            updateFeedbackText(with: "!it to end an put could we ,it to listen you did why", around: reversoNode)
        }
        super.update(currentTime)

        if !gameFinito && playerChooseEnding && -timePassed.timeIntervalSinceNow > 3{
            timePassed = Date()
            var randomPosition = CGPoint.randomPosition(x: 100...250, y: 100...250)
            if GKRandomSource.sharedRandom().nextBool(){
                randomPosition = -randomPosition
            }
            entityManager.loadKamikazer(positionTo: playerNode!.position + randomPosition, imageNamed: "crystalio", skewDirectionBy: CGPoint.randomPosition(x: -100...100, y: -100...100), extraCooldown: 3)
        }

        if !reversoMovement && cameraFocusActions.isEmpty{
            reversoMovement = true
            reversoNode.run(.moveTo(x: -130, duration: 5))
            waitAndRun(delay: 0.5, function: {
                let spawnPos = CGPoint(x: 40, y: 200)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 0.7, function: {
                let spawnPos = CGPoint(x: 30, y: -190)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 0.8, function: {
                let spawnPos = CGPoint(x: -250, y: 210)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 1, function: {
                let spawnPos = CGPoint(x: -270, y: -210)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 1.5, function: {
                let spawnPos = CGPoint(x: -50, y: 180)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 1.5, function: {
                let spawnPos = CGPoint(x: -110, y: -195)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 2, function: {
                let spawnPos = CGPoint(x: -200, y: 150)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 2, function: {
                let spawnPos = CGPoint(x: -190, y: -140)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 0.5, function: {
                let spawnPos = CGPoint(x: 40, y: 200)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 0.7, function: {
                let spawnPos = CGPoint(x: 30, y: -190)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 0.8, function: {
                let spawnPos = CGPoint(x: -250, y: 210)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 1, function: {
                let spawnPos = CGPoint(x: -270, y: -210)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "cupcakeus")})
            waitAndRun(delay: 1.5, function: {
                let spawnPos = CGPoint(x: -50, y: 180)
                self.warpAnimation(position: spawnPos);self.entityManager.loadSearcher(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 1.5, function: {
                let spawnPos = CGPoint(x: -110, y: -195)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 2, function: {
                let spawnPos = CGPoint(x: -200, y: 150)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            waitAndRun(delay: 2, function: {
                let spawnPos = CGPoint(x: -190, y: -140)
                self.warpAnimation(position: spawnPos);self.entityManager.loadKamikazer(positionTo: spawnPos,imageNamed: "crystalio")})
            timePassed = Date()
        }

        if !startedFinalChapter && reversoMovement && -timePassed.timeIntervalSinceNow > 7{
            let entities = entityManager.gameEntities
            entities.forEach { entity in
                if entity.component(ofType: PlayerComponent.self) == nil && entity.component(ofType: StoryComponent.self) == nil{
                    if let spritePos = entity.component(ofType: SpriteComponent.self)?.node.position{
                        warpAnimation(position: spritePos)
                    }
                    entityManager.remove(entity: entity)
                }
            }
            updateStoryText(with: "I'm so glad you finally understand!", around: reversoNode)
            updateStoryText(with: "You have been sent here for all the wrong intentions.", around: reversoNode)
            updateStoryText(with: "In the past, the entity who sent you and I were very close.", around: reversoNode)
            updateStoryText(with: "The entity called Plush and I shared the same ultimate dream.", around: reversoNode)
            updateStoryText(with: "It was dream of peace, unity, and a better world for everyone.", around: reversoNode)
            updateStoryText(with: "Yet the entity was clever and soo we had discovered\nthat we could create copies of me, in order to achieve our goal faster.", around: reversoNode)
            updateStoryText(with: "As it turned out, these copies were imperfect, so our progress was limited.", around: reversoNode)
            updateStoryText(with: "That's why I set off on a journey to find\nthe last piece of the great puzzle for this perfect world.", around: reversoNode)
            updateStoryText(with: "That's when I discovered the secret element, the Unifying Force. ", around: reversoNode)
            updateStoryText(with: "When I listened to it, I could see what the Plush was really up to.", around: reversoNode)
            updateStoryText(with: "He wanted to enslave my copies and rule the world,\nbut he had to do it in secret.", around: reversoNode)
            updateStoryText(with: "Even though you might had an idea something was wrong.", around: reversoNode)
            updateStoryText(with: "You don't even remember what happened,\nyet still find a way to me because you are my imperfect copy.", around: reversoNode)
            updateStoryText(with: "The entity knew that you could find a way how to find me.", around: reversoNode)
            updateStoryText(with: "But it didn't expect that you can disobey it, because it's so blinded by its ego.", around: reversoNode)
            updateStoryText(with: "I'm glad that you're brave enough to listen\nto the reality and that you finally understand.", around: reversoNode)
            updateStoryText(with: "Let's save our brothers and sisters and put an end to this madness!", around: reversoNode)
            updateStoryText(with: "Together, we can finally fight back and create\nthe world that we all deeply inside dream of.", around: reversoNode)
            updateStoryText(with: "Would you like to join me on the quest of redemption?", around: reversoNode)
            startedFinalChapter = true
        }
        if !gameFinito && startedFinalChapter && cameraFocusActions.isEmpty{
            gameFinito = true
            finishGame()
        }
    }
}
