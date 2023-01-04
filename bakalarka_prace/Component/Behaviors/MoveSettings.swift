//
//  MoveSettings.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class MoveSettings: GKBehavior {


    //MARK: - KAMIKAZE TO PLAYER NPC
    init(npc: GKEntity, targetSpeed: Float, searchFor: GKAgent, avoid: [GKAgent], player: GKEntity, unlimitedDistance: Bool = false, protectEntity: GKAgent? = nil, kamikazeComp: KamikazeComponent) {
        super.init()
        // kontrola stealth módu
        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node
        let playerVelocity = playerSprite?.physicsBody?.velocity
        let distanceToPlayer = ((playerSprite?.position)! - (npcSprite?.position)!).length()

        let zeroMovement = CGVector(dx: 0, dy: 0)

        // TESTING GUARDING
        if protectEntity == nil {
            if kamikazeComp.isKamikazeFinished() && targetSpeed > 0 && playerVelocity! > zeroMovement && (distanceToPlayer < 220 || unlimitedDistance) {
                //weight reprezentuje jaký cíl má větší váhu(prioritu) 100 - vysoká, 0 - nízká
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                if kamikazeComp.canKamikazeAgain(){
                    kamikazeComp.kamikaze(toNode: playerSprite!)
                }
                setWeight(0, for: GKGoal(toWander: 200))
            }else if kamikazeComp.isKamikazeFinished() && targetSpeed > 0 && playerVelocity! > zeroMovement && (distanceToPlayer < 300 || unlimitedDistance) {
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(0, for: GKGoal(toWander: 200))
            } else if kamikazeComp.isKamikazeFinished() && targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer > 300 {
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(5, for: GKGoal(toSeekAgent: searchFor))
                setWeight(30, for: GKGoal(toWander: 200))
            }
            //pokud jsme pohyblivá jednotka a hráč je ve stealth módu
            else if playerVelocity! == zeroMovement {
                var avoidWithPlayer = avoid
                avoidWithPlayer.append(searchFor)

                setWeight(50, for: GKGoal(toWander: 200))
                setWeight(60, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 25))
                setWeight(0, for: GKGoal(toSeekAgent: searchFor))
            }
        }else{
            if kamikazeComp.isKamikazeFinished() && targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer < 220{
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 10))
                setWeight(45, for: GKGoal(toCohereWith: [protectEntity! as GKAgent], maxDistance: 1000, maxAngle: .pi ))
                if kamikazeComp.canKamikazeAgain(){
                    kamikazeComp.kamikaze(toNode: playerSprite!)
                }
                setWeight(50, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else if kamikazeComp.isKamikazeFinished() && targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer < 400{
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 10))
                setWeight(45, for: GKGoal(toCohereWith: [protectEntity! as GKAgent], maxDistance: 1000, maxAngle: .pi ))
                setWeight(50, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else {
                var avoidWithPlayer = avoid
                avoidWithPlayer.append(searchFor)

                setWeight(60, for:GKGoal(toCohereWith: [protectEntity! as GKAgent], maxDistance: 1000, maxAngle: .pi))
                setWeight(50, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 5))
                setWeight(40, for: GKGoal(toWander: 200))
                setWeight(0, for: GKGoal(toSeekAgent: searchFor))
            }
        }
    }
        
    
    //MARK: - SEARCH FOR PLAYER NPC
    init(npc: GKEntity,targetSpeed: Float, searchFor: GKAgent, avoid: [GKAgent], player: GKEntity, unlimitedDistance: Bool = false, protectEntity: GKAgent? = nil) {
        super.init()
        // kontrola stealth módu
        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node
        let playerVelocity = playerSprite?.physicsBody?.velocity
        let distanceToPlayer = ((playerSprite?.position)! - (npcSprite?.position)!).length()

        let zeroMovement = CGVector(dx: 0, dy: 0)
        
        // TESTING GUARDING
        if protectEntity == nil{
            if targetSpeed > 0 && playerVelocity! > zeroMovement && (distanceToPlayer < 500 || unlimitedDistance) {
                //weight reprezentuje jaký cíl má větší váhu(prioritu) 100 - vysoká, 0 - nízká
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(30, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else if targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer > 500{
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(5, for: GKGoal(toSeekAgent: searchFor))
                setWeight(30, for: GKGoal(toWander: 200))
            }
            //pokud jsme pohyblivá jednotka a hráč je ve stealth módu
            else if playerVelocity! == zeroMovement{
                var avoidWithPlayer = avoid
                avoidWithPlayer.append(searchFor)
                
                setWeight(50, for: GKGoal(toWander: 200))
                setWeight(60, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 25))
                setWeight(0, for: GKGoal(toSeekAgent: searchFor))
            }
        }
        else{
            if targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer < 500{
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 10))
                setWeight(55, for: GKGoal(toCohereWith: [protectEntity!,npc.component(ofType: MoveComponent.self)!], maxDistance: 280, maxAngle: .pi ))

                setWeight(50, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else {
                var avoidWithPlayer = avoid
                avoidWithPlayer.append(searchFor)
                setWeight(60, for:GKGoal(toCohereWith: [protectEntity!,npc.component(ofType: MoveComponent.self)!], maxDistance: 280, maxAngle: .pi))
                setWeight(50, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 5))
                setWeight(40, for: GKGoal(toWander: 200))
                setWeight(0, for: GKGoal(toSeekAgent: searchFor))
            }
        }
    }
    
    //MARK: - INTERACT NPC (MSG)
    init(npc: GKEntity,avoid: [GKAgent],player: GKEntity) {
        super.init()
        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node
        let distance = ((playerSprite?.position)! - (npcSprite?.position)!).length()
        
        var av = avoid
        av.append(player.component(ofType: MoveComponent.self)!)
        
        if distance < 190, let msg = npc.component(ofType: MessageComponent.self) {
                msg.showMsg()
            }
        // story teller
        if let msg = npc.component(ofType: StoryComponent.self), distance < 290{
            if let trigger = npc.component(ofType: TriggerComponent.self){
                if trigger.isTriggered{
//                    trigger.finished()
                    msg.tellStory()
                }
            }else{
                msg.tellStory()
            }
        }

        setWeight(60, for: GKGoal(toAvoid: av, maxPredictionTime: 10))
        setWeight(50, for: GKGoal(toWander: 12389))
    }
    
    //MARK: - INTERACT NPC (MSG, WARNING)
    init(npc: GKEntity,avoid: [GKAgent],player: GKEntity, enemy: GKEntity?) {
        super.init()

        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node

        let playerDistance = ((playerSprite?.position)! - (npcSprite?.position)!).length()

        var av = avoid
        av.append(player.component(ofType: MoveComponent.self)!)

        // story teller
        if let msg = npc.component(ofType: StoryComponent.self), playerDistance < 290{
            if let trigger = npc.component(ofType: TriggerComponent.self){
                if trigger.isTriggered{
//                    trigger.finished()
                    msg.tellStory()
                }
            }else{
                msg.tellStory()
            }
        }

        setWeight(60, for: GKGoal(toAvoid: av, maxPredictionTime: 10))
//         TODO: - SEARCH FOR IF LET SO I CAN SEE IF I AIN'T IGNORING SMT
        if let enemySprite = enemy?.component(ofType: SpriteComponent.self)!.node{
            let enemyDistance = (enemySprite.position - (npcSprite?.position)!).length()
            if let msg = npc.component(ofType: MessageComponent.self),playerDistance < 190{
                if enemyDistance < 400 {
                    msg.showWarningMsg()
                }
                else{
                    msg.showMsg()
                }
            }
        }
        else {
            if let msg = npc.component(ofType: MessageComponent.self),playerDistance < 190 {
                msg.showMsg()
            }
        }
        //Due to very poor documentation GKBehavoir, I've decided to use this magic constant
        //as it was producing the best(for my game) results
        setWeight(50, for: GKGoal(toWander: 12389))
    }
    
}
