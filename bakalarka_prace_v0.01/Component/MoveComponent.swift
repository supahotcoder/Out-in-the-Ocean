//
//  MoveComponent.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class MoveComponent : GKAgent2D, GKAgentDelegate{
    
    let entityManager : EntityManager
    
    init(maxSpeed: Float, maxAcceleration: Float, effectiveRadius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration

        self.radius = effectiveRadius
        self.mass = 0.1
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self)
            else{
                return
        }
        position = float2(tuple: spriteComponent.node.position.floatConvetor())
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self)
            else{
                return
        }
        spriteComponent.node.position = CGPoint(tuple: position.doubleConvetor())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        let avoidOthers = entityManager.avoidEntities()
        
        // player se defaultně vyřazuje protože ho ovládá hráč
        if entity?.component(ofType: PlayerComponent.self) == nil{
            let player = entityManager.player() // nalezení hráče
            let target = player?.component(ofType: MoveComponent.self)

            behavior = MoveSettings(targetSpeed: maxSpeed, searchFor: target!, avoid: avoidOthers)
        }
    }
    
}
