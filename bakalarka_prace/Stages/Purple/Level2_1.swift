//
//  Level2.swift
//
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Level2_1: Level2 {
    
    private var key1: Collectible?
    private var key2: Collectible?

    private var storyTeller: StoryTeller?
    private var storyTellerNode: SKSpriteNode?
    private var triggerComponent: TriggerComponent?
    private var closestKeyToRemove: Collectible?

    private var dialogController: DialogController?
    private var dialogStoryResolution: Int = 0
    private var lastTouched: SKNode?

    var didPlayerGatheredInfo: Bool = false
    private var wasBetrayed: Bool = false
    private var didSlimeTeleported: Bool = false

    override func didMove(to view: SKView) {
        self.name = "Level2_1"
        //MUSIC SETUP
        backgroundMusic(fileName: "level2-1-sound", extension: "wav")
        // BACKGROUND BOUNDARY
        background = childNode(withName: "background") as? SKSpriteNode
        physicsBody =  SKPhysicsBody(edgeLoopFrom: background!.frame)
        //PLAYER POSITION
        playerSpawnPosition = CGPoint(x: -800,y: 0)

        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level2-1")
        // EMITTER
        let fluidCrystals = SKEmitterNode(fileNamed: "FluidEffect")!
        fluidCrystals.position = CGPoint(x: 0, y: 0)
        fluidCrystals.zPosition = 2
        self.addChild(fluidCrystals)


        //      SETTING UP MINERALS
        let minerals = StaticBackground(imageName: "minerals", entityManager: entityManager)
        minerals.spriteComp.node.zPosition = 3
        minerals.spriteComp.node.position = CGPoint(x: 0, y: 0)
        entityManager.add(entity: minerals)

        // SEARCHERS
        var crystalios: [SKNode?] = []
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint(x: -900, y: 680), imageNamed: "crystalio"))
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint(x: -900, y: -680), imageNamed: "crystalio"))
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
//        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
//        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
//        crystalios.append(entityManager.loadKamikazer(positionTo: CGPoint.randomPosition(x: -200...1100, y: -680...680), imageNamed: "crystalio"))
        for enemyNode in crystalios{
            enemyNode?.physicsBody?.collisionBitMask &= bitmasks.player.rawValue
            enemyNode?.physicsBody?.collisionBitMask &= bitmasks.frame.rawValue
        }
        // STORY TELLER
        let slime = entityManager.loadStoryTeller(storyToTell: [""], imageNamed: "slime", triggerable: true, position: CGPoint(x: -960, y: 0), rotation: CGFloat(0))
        
        storyTellerNode = slime.node
        storyTeller = slime.entity
        
        updateStoryText(with: "Ok we are here.\nFrom now on you will be moving on your own.", around: storyTellerNode!)
        updateStoryText(with: "Bring me the key\nand I will show you how to use it properly", around: storyTellerNode!)

        if let triggerComp = storyTeller?.component(ofType: TriggerComponent.self){
            triggerComponent = triggerComp
            triggerComp.didTrigger()
        }
        //        DIALOG SETUP
        dialogController = DialogController(gameScene: self)

        //        COLLECTIBLES
        key1 = Collectible(imageNamed: "crystal-key", size: BodyPathsBodySizes.getBodySize(textureName: "crystal-key"), id: "1", protectable: false, entityManager: entityManager, location: CGPoint(x: 432, y: -564))
        key1?.spriteComp.node.zRotation = -560
        
        key2 = Collectible(imageNamed: "crystal-key", size: BodyPathsBodySizes.getBodySize(textureName: "crystal-key"), id: "2", protectable: false, entityManager: entityManager, location: CGPoint(x: 1100, y: 695))
        key2?.spriteComp.node.zRotation = 205
        
        entityManager.add(entity: key1!)
        entityManager.add(entity: key2!)
        
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)

        let otherNode: SKPhysicsBody

        if contact.bodyA.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyB
        } else if contact.bodyB.node?.physicsBody?.categoryBitMask == playerNode?.physicsBody?.categoryBitMask {
            otherNode = contact.bodyA
        } else {
            return
        }

        if otherNode.categoryBitMask == bitmasks.searcher.rawValue ||
                   otherNode.categoryBitMask == bitmasks.activeBackground.rawValue
                   || otherNode.categoryBitMask == bitmasks.frame.rawValue{
            gameOver()
        }

        if !(dialogController?.active ?? false) && (otherNode.node != lastTouched || wasBetrayed) && dialogController?.finished ?? false
                   && otherNode.categoryBitMask == bitmasks.collectible.rawValue {
            var showingDialog = true
            if didPlayerGatheredInfo && !wasBetrayed{
//                dialog hrac vi ze nemusi verit slime
                dialogController?.setUpNewDialogs(dialog1TextAndID: ("Use it", 1), dialog2TextAndID: ("Push it", 2))
            } else if !wasBetrayed{
                dialogStoryResolution = 2 // bez dialogu jelikoz hrac v predchozim levlu nedostal indicie
                storyTeller?.addAnotherStory(story:
                                                ["Impressive, I see","Finally one of them is in my hands.\nI can't belive it!", "Just watch, this is how it works.", "Uh and good luck finding another one.","Haha uaaah?"], completion: { () in self.closestKeyToRemove?.collect();self.wasBetrayed = true;self.triggerComponent?.finished()})
                showingDialog = false
            } else if wasBetrayed{
                showingDialog = false
                self.updateStoryText(with: "Ok let's go!", around: playerNode!)
                nextLevel()
            }
            if showingDialog{
                pauseGameState()
                playerNode?.isPaused = true
                dialogController?.showDialog(parentNode: camera!);
            }
        }
        lastTouched = otherNode.node
    }

    //MARK: - TOUCHES
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!(dialogController?.finished ?? false)) {
            dialogStoryResolution = dialogController?.dialogResolution(touches: touches, touchedIn: camera!) ?? 0
            if dialogStoryResolution == 1 {
//                  klice je pouzity
                self.updateStoryText(with: "Ok let's go!", around: playerNode!)
                nextLevel()
            } else if dialogStoryResolution == 2 {
//                  klic byl prinesen
                storyTeller?.addAnotherStory(story:
                ["Impressive, I see","Finally one of them is in my hands.\nI can't belive it!", "Just watch, this is how it works.", "Uh and good luck finding another one.","Haha uaaah?"], completion: { () in self.closestKeyToRemove?.collect();self.wasBetrayed = true;self.triggerComponent?.finished()})
            }
            resumeGameState()
        }
        super.touchesBegan(touches, with: event)
    }

    private func nextLevel() {
        changingLevel = true
        let warp = SKEmitterNode(fileNamed: "Warp2")!
        warp.position = (playerNode?.position)!
        warp.zPosition = 6
        self.addChild(warp)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }

    override func update(_ currentTime: TimeInterval) {
        if  ((storyTellerNode?.position)! - (key1?.spriteComp.node.position)!).length() < 300{
            closestKeyToRemove = key1
            triggerComponent?.didTrigger()
        }else if ((storyTellerNode?.position)! - (key2?.spriteComp.node.position)!).length() < 300{
            closestKeyToRemove = key2
            triggerComponent?.didTrigger()
        }else if dialogStoryResolution == 2{
            triggerComponent?.canceled()
        }
        
        super.update(currentTime)
        
        
        if !didSlimeTeleported && wasBetrayed && cameraFocusActions.isEmpty && storyTellingActions.isEmpty{
            let warp = SKEmitterNode(fileNamed: "Warp2")!
            warp.position = (storyTellerNode?.position)!
            warp.zPosition = 6
            self.addChild(warp)
            didSlimeTeleported = true
            self.storyTellerNode?.removeFromParent()
            self.updateStoryText(with: "All right that didn't go as planned", around: self.playerNode!)
            self.updateStoryText(with: "He just bailed on me", around: self.playerNode!)
            self.updateStoryText(with: "But I'm sure he mentioned \"one\",\nso there could be more of them.", around: self.playerNode!)
            self.updateStoryText(with: "I should explore this place even more.", around: self.playerNode!)
        }
    }
    
}
