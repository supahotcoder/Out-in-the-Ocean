//
//  Game.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import GameplayKit
import SpriteKit

class EntityManager {
    
    private(set) var gameEntities = Set<GKEntity>()
    
    private(set) var scene : SKScene? // možná se bude měnit podle levelu, proto var
    
    private(set) var player: GKEntity? = nil
    
    private(set) var enemies = Set<GKEntity>()
    
    var gameOver = false
    
     init(scene : SKScene) {
        self.scene = scene
    }
    
    func addMsg(msgLabel: SKLabelNode) {
        if !gameOver {
            scene?.addChild(msgLabel)
        }
    }
    
    private func addPlayer(player: GKEntity) {
        self.player = player
    }
    
    func add(entity: GKEntity){
        gameEntities.insert(entity)
        // přistupování k vlastonsti SpriteComponent (SKSpriteNode)
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node{
            scene?.addChild(spriteNode)
        }
    }

    func remove(entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        gameEntities.remove(entity)
    }
    
    //MARK: - MOVECOMPONENT UTILITIES
    
    func enemy() -> GKEntity {
        // promíchá protivníky
        enemies = Set(enemies.shuffled().map{$0})
        return enemies.first!
    }
    
    func entitiesWithMoveComponent() -> [MoveComponent] {
        var moveComponents = [MoveComponent]()
        for entity in gameEntities{
            if let entity = entity.component(ofType: MoveComponent.self){
                moveComponents.append(entity)
            }
        }
        return moveComponents
    }
    
    
    func update(_ deltaTime: CFTimeInterval) {
        for up in entitiesWithMoveComponent(){
            up.update(deltaTime: deltaTime)
        }
    }
    
    func protectEntities() -> [MoveComponent] {
        var guards = [MoveComponent]()
        for entity in gameEntities{
            if entity.component(ofType: ProtectComponent.self) != nil{
                guards.append(entity.component(ofType: MoveComponent.self)!)
            }
        }
        return guards
    }
    
    func avoidEntities() -> [MoveComponent] {
        var avoid = [MoveComponent]()
        for entity in gameEntities{
            if entity.component(ofType: AvoidCollisionComponent.self) != nil{
                avoid.append(entity.component(ofType: MoveComponent.self)!)
            }
        }
        return avoid
    }
    
    //MARK: - SETUPS
    
    func loadPlayer(position: CGPoint) -> SKSpriteNode? {
        let player = Player(imageName: "player_test", entityManager: self)
        addPlayer(player: player)
        if let pNode = player.component(ofType: SpriteComponent.self)?.node {
            pNode.position =  position
            // nastavení Z pozice
            pNode.zPosition = 3
            self.add(entity: player)
            return pNode
        }
        return nil
    }
    //MARK: Loading Entities
    func loadSearcher() {
        let searcher = Searcher(imageName: "evil_player1", entityManager: self)
        if let sNode = searcher.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: 0...500,y: 0...640)
            sNode.zPosition = 3
            self.add(entity: searcher)
        }
        enemies.insert(searcher)
    }
    
    func loadActiveBackground(imageName: String) -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: imageName,entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint.randomPosition(x: 0...840,y: 0...640)
            //CGPoint(x: Int.random(in: 0...840) - Int.random(in: 0...840), y: Int.random(in: 0...640) - Int.random(in: 0...640))
            acNode.zRotation = CGFloat.random(in: 0...360)
            acNode.zPosition = 3
            self.add(entity: activeBack)
            return activeBack
        }
        return nil
    }
    
    func loadWarper() -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: "spin",entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint.randomPosition(x: 0...840,y: 0...640)
            acNode.zRotation = CGFloat.random(in: 0...360)
            acNode.zPosition = 3
            acNode.run(SKAction.rotate(byAngle: 30, duration: 100))
            self.add(entity: activeBack)
            return activeBack
        }
        return nil
    }
    
    func loadWander(messages: [String] = [""], loopOn: Int = -1, warningMsgs: [String] = [""]) {
        let wander: Wander
        if messages == [""]{
            wander = Wander(entityManager: self)
        }
        else{
            wander = Wander(entityManager: self, messages: messages, loopMessagesOn: loopOn,warningMsgs: warningMsgs)
        }
        if let sNode = wander.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: 0...840,y: 0...640)
            sNode.zRotation = CGFloat.random(in: 0...360)
            sNode.zPosition = 3
            self.add(entity: wander)
        }
    }
    
}
