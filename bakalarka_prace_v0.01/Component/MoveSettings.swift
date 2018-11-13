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
    
    init(targetSpeed: Float, searchFor: GKAgent, avoid: [GKAgent]) {
        super.init()
        // pokud jsme pohyblivá jednotka
        if targetSpeed > 0{
            //weight reprezentuje jaký cíl má větší váhu(prioritu) 1 - vysoká, 0 - nízká
            setWeight(60, for: GKGoal(toAvoid: avoid, maxPredictionTime: 25))
            
            setWeight(5, for: GKGoal(toSeekAgent: searchFor))
        }
    }
    
}
