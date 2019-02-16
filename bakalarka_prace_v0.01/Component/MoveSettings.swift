//
//  MoveSettings.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 09/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class MoveSettings: GKBehavior {
    
    
    //MARK: - SEARCH FOR PLAYER NPC
    init(npc: GKEntity,targetSpeed: Float, searchFor: GKAgent, avoid: [GKAgent], player: GKEntity, unlimitedDistance: Bool = false, protectEntities: [GKAgent?] = [nil]) {
        super.init()
        // kontrola stealth módu
        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node
        let playerVelocity = playerSprite?.physicsBody?.velocity
        let distanceToPlayer = ((playerSprite?.position)! - (npcSprite?.position)!).length()

        let zeroMovement = CGVector(dx: 0, dy: 0)
        
        // TESTING GUARDING
        if protectEntities == [nil]{
            if targetSpeed > 0 && playerVelocity! > zeroMovement && (distanceToPlayer < 700 || unlimitedDistance) {
                //weight reprezentuje jaký cíl má větší váhu(prioritu) 100 - vysoká, 0 - nízká
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(30, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else if targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer > 700{
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
            if targetSpeed > 0 && playerVelocity! > zeroMovement && distanceToPlayer < 700{
                setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
                setWeight(30, for: GKGoal(toCohereWith: protectEntities as! [GKAgent], maxDistance: 700, maxAngle: .pi))
                setWeight(50, for: GKGoal(toSeekAgent: searchFor))
                setWeight(0, for: GKGoal(toWander: 200))
            }
            else {
                var avoidWithPlayer = avoid
                avoidWithPlayer.append(searchFor)
                
                setWeight(50, for:GKGoal(toCohereWith: protectEntities as! [GKAgent], maxDistance: 500, maxAngle: .pi))
                setWeight(60, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 25))
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
        
        setWeight(60, for: GKGoal(toAvoid: av, maxPredictionTime: 10))
        setWeight(50, for: GKGoal(toWander: 12389))
    }
    
    //MARK: - INTERACT NPC (MSG, WARNING)
    init(npc: GKEntity,avoid: [GKAgent],player: GKEntity, enemy: GKEntity) {
        super.init()
        let enemySprite = enemy.component(ofType: SpriteComponent.self)!.node
        let playerSprite = player.component(ofType: SpriteComponent.self)?.node
        let npcSprite = npc.component(ofType: SpriteComponent.self)?.node
        
        let playerDistance = ((playerSprite?.position)! - (npcSprite?.position)!).length()
        let enemyDistance = (enemySprite.position - (npcSprite?.position)!).length()
        
        var av = avoid
        av.append(player.component(ofType: MoveComponent.self)!)
        
        if let msg = npc.component(ofType: MessageComponent.self),playerDistance < 190{
            if enemyDistance < 400{
                msg.showWarningMsg()
            }
                
            else{
                msg.showMsg()
            }
        }
        setWeight(60, for: GKGoal(toAvoid: av, maxPredictionTime: 10))
        setWeight(50, for: GKGoal(toWander: 12389))
    }
    
}
