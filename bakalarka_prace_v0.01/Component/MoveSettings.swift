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
    
    init(targetSpeed: Float, searchFor: GKAgent, avoid: [GKAgent], player: GKEntity) {
        super.init()
        // kontrola stealth módu
        let playerVelocity = player.component(ofType: SpriteComponent.self)?.node.physicsBody?.velocity
        
        let zeroMovement = CGVector(dx: 0, dy: 0)
        // pokud jsme pohyblivá jednotka a hráč je ve stealth módu
        if targetSpeed > 0 && playerVelocity! > zeroMovement{
            //weight reprezentuje jaký cíl má větší váhu(prioritu) 1 - vysoká, 0 - nízká
            setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
            setWeight(15, for: GKGoal(toSeekAgent: searchFor))
            setWeight(0, for: GKGoal(toWander: 200))
        }
        else if playerVelocity! == zeroMovement{
            var avoidWithPlayer = avoid
            avoidWithPlayer.append(searchFor)
            
            setWeight(100, for: GKGoal(toWander: 200))
            setWeight(60, for: GKGoal(toAvoid: avoidWithPlayer, maxPredictionTime: 25))
            setWeight(0, for: GKGoal(toSeekAgent: searchFor))
        }
    }
    
}
