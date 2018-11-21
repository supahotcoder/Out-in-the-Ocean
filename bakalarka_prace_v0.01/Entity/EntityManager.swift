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
    
     init(scene : SKScene) {
        self.scene = scene
        loadGame()
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
    
    func entitiesWithMoveComponent() -> [MoveComponent] {
        var moveComponents = [MoveComponent]()
        for entity in gameEntities{
            if let entity = entity.component(ofType: MoveComponent.self){
                moveComponents.append(entity)
            }
        }
        return moveComponents
    }
    
    //TODO: - Možná přepsat na konstantu at je to ryhlejší
    func player() -> GKEntity? {
        for entity in gameEntities {
            if entity.component(ofType: PlayerComponent.self) != nil{
                return entity
            }
        }
        return nil
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        for up in entitiesWithMoveComponent(){
            up.update(deltaTime: deltaTime)
        }
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
        if let pNode = player.component(ofType: SpriteComponent.self)?.node {
            pNode.position =  position
            // nastavení Z pozice
            pNode.zPosition = 3
            self.add(entity: player)
            return pNode
        }
        return nil
    }
    
    func loadSearcher() {
        let searcher = Searcher(imageName: "player_test", entityManager: self)
        if let sNode = searcher.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint(x: 100 , y: 200)
            sNode.zPosition = 3
            self.add(entity: searcher)
        }
    }
    
    func loadActiveBackground() -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: "rucka",entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint(x: Int(arc4random_uniform(840)) - Int(arc4random_uniform(840)), y: Int(arc4random_uniform(640)) - Int(arc4random_uniform(640)))
            acNode.zRotation = CGFloat(arc4random_uniform(360))
            acNode.zPosition = 3
            self.add(entity: activeBack)
            return activeBack
        }
        return nil
    }
    
    private func loadGame() {
    //TODO:
    }
}
