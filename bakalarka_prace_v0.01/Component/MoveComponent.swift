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
    
    func resetAgentDelegate() {
        self.delegate = self
    }
    
    init(maxSpeed: Float, maxAcceleration: Float, effectiveRadius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration

        self.radius = effectiveRadius
        self.mass = 0.1
    }
    //MARK: - AGENTS
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
        let pos = CGPoint(tuple: position.doubleConvetor())
        
        //sprite je otočený směrem kde se pohybuje
        if spriteComponent.node.physicsBody?.categoryBitMask == bitmasks.searcher.rawValue{
            let direction = spriteComponent.node.position - pos
            let angle = atan2(direction.y , direction.x) + CGFloat.pi / 2 + 1.5
            spriteComponent.node.run(SKAction.rotate(toAngle:angle, duration: 0.9, shortestUnitArc: true))
            //sprite.zRotation = angle
            //CGPoint(x: sprite.position.x + cos(sprite.zRotation) * 10, y: sprite.position.y + cos(sprite.zRotation) * 10)
        }
        
        spriteComponent.node.position = pos
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UPDATE
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        let player = entityManager.player
        let playerDistance = ((player?.component(ofType: SpriteComponent.self)?.node.position)! - (entity?.component(ofType: SpriteComponent.self)?.node.position)!).length()
        if (entity?.component(ofType: StoryComponent.self) != nil){
//            TUTAJ NASETUJ BEHAVIOR PRO STORY COMPONNENT
//        TODO: - DELEJ SPINKO ALE
//            print("story" ,"test ", playerDistance)
        }
        
        let avoidOthers = entityManager.avoidEntities()
        // player se defaultně vyřazuje protože ho ovládá hráč
        
        //Typ 1: nevyhledává hráče, brouzdá po mapě
        if entity?.component(ofType: AvoidCollisionComponent.self) != nil && entity?.component(ofType: PlayerComponent.self) == nil{
            let player = entityManager.player
            //behavior = MoveSettings(npc: entity!, avoid: avoidOthers, player: player!)
//            if (entity?.component(ofType: StoryComponent.self) != nil){print("type 1")}
            behavior = MoveSettings(npc: entity!, avoid: avoidOthers, player: player!, enemy: entityManager.enemy() ?? nil)
        }
        //Typ 2: Ochraňuje entitu a napadá hráče
        else if (entity?.component(ofType: GuardComponent.self)) != nil{
            let player = entityManager.player // nalezení hráče
            let target = player?.component(ofType: MoveComponent.self)
            let protect = entityManager.closestProtectionComponent(from: CGPoint(tuple: position.doubleConvetor()))
//            if (entity?.component(ofType: StoryComponent.self) != nil){print("type 2")}

            behavior = MoveSettings(npc: entity!,targetSpeed: maxSpeed, searchFor: target!, avoid: avoidOthers, player: player!,protectEntity: protect)
        }
        //Typ 3: vyhledávání hráče
            //TODO: - změnit na ENemyComponent check
        else if entity?.component(ofType: PlayerComponent.self) == nil && entity?.component(ofType: AvoidCollisionComponent.self) == nil{
            let player = entityManager.player // nalezení hráče
            let target = player?.component(ofType: MoveComponent.self)
//            if (entity?.component(ofType: StoryComponent.self) != nil){print("type 3")}

            behavior = MoveSettings(npc: entity!,targetSpeed: maxSpeed, searchFor: target!, avoid: avoidOthers, player: player!)
        }
        // Zabraňování kolizí z okrajem mapy
        let backgroundObstacle = SKNode.obstacles(fromNodePhysicsBodies: [(entityManager.scene?.physicsBody?.node)!])
        
        behavior?.setWeight(100, for: GKGoal(toAvoid: backgroundObstacle, maxPredictionTime: 10))
    }
    
}
