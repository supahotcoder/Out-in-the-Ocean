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
    
    //Přidání zprávy(label) pokud není gameOver
    func addMsg(msgLabel: SKLabelNode) {
        if !gameOver {
            scene?.addChild(msgLabel)
        }
    }

    func addComponentToPlayer(component: GKComponent) {
        player?.addComponent(component)
    }

    func tellStory(text: String, around: SKNode,fadeIn: TimeInterval, fadeOut: TimeInterval) -> SKLabelNode? {
        if !gameOver{
            if let scn = scene as? GameSceneClass  {
                let timeUntilNextText = TimeInterval(text.count / 3) + fadeIn + fadeOut - 0.5
                return scn.updateStoryText(with: text, around: around, displayIn: fadeIn, fadeOut: fadeOut, timeToFocusOn: timeUntilNextText)
            }
        }
        return nil
    }

//    func getEntityFromNode(SKNode: node) -> [GKEntity]{
//        gameEntities.filter { entity in entity.component(ofType: SpriteComponent.self)!.node. }
//    }

    //Uložení hráče do proměnné (Optimalizace na výkon)
    private func setPlayer(player: GKEntity) {
        self.player = player
    }
    
    //Přidání entity do EntityManager systému a do Scény (úrovně)
    func add(entity: GKEntity){
        gameEntities.insert(entity)
        // přistupování k vlastonsti SpriteComponent (SKSpriteNode)
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node{
            scene?.addChild(spriteNode)
        }
    }
    
    //Odstranění entity z EntityManager systému a ze Scény (úrovně)
    func remove(entity: GKEntity) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            spriteNode.removeFromParent()
        }
        gameEntities.remove(entity)
    }
    
    //MARK: - MOVECOMPONENT UTILITIES
    
    func enemy() -> GKEntity? {
        // promíchá protivníky
        enemies = Set(enemies.shuffled().map{$0})
        return enemies.first ?? nil
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
    
    //Aktualizace pohybu (více ve třídě MoveComponent)
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
    
    func closestProtectionComponent(from: CGPoint) -> GKAgent2D? {
        var closestEntity: MoveComponent? = nil
        var closestDistance = CGFloat(0)
        let protect = protectEntities()
        for entity in protect{
            let distance = (from - CGPoint(tuple: entity.position.doubleConvetor())).length()
            if closestEntity == nil || distance < closestDistance{
                closestEntity = entity
                closestDistance = distance
            }
        }
        return closestEntity
    }
    
    //MARK: - SETUPS

    func loadPlayer(position: CGPoint) -> SKSpriteNode? {
        let player = Player(imageName: "player_test", entityManager: self)
        setPlayer(player: player)
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
    @discardableResult
    func loadSearcher() -> SKNode?{
        let searcher = Searcher(imageName: "evil_player1", entityManager: self)
        if let sNode = searcher.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: 100...840,y: -640...640)
            sNode.zPosition = 3
            self.add(entity: searcher)
            return sNode
        }
        enemies.insert(searcher)
        return nil
    }
    
    func loadActiveBackground(imageName: String) -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: imageName,entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint.randomPosition(x: -840...840,y: -640...640)
            //CGPoint(x: Int.random(in: 0...840) - Int.random(in: 0...840), y: Int.random(in: 0...640) - Int.random(in: 0...640))
            acNode.zRotation = CGFloat.random(in: 0...360)
            acNode.zPosition = 3
            self.add(entity: activeBack)
            return activeBack
        }
        return nil
    }
    

    
    // NEPOUŽÍVAT !!!!
    // Todo: - change or delete
    func loadWarper() -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: "spin",entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint.randomPosition(x: -840...840,y: -640...640)
            acNode.zRotation = CGFloat.random(in: 0...360)
            acNode.zPosition = 3
            //acNode.run(SKAction.rotate(byAngle: 30, duration: 100))
            self.add(entity: activeBack)
            return activeBack
        }
        return nil
    }
    @discardableResult
    func loadWander(messages: [String] = [""], loopOn: Int = -1, warningMsgs: [String] = [""]) -> SKNode? {
        let wander: Wander
        if messages == [""]{
            wander = Wander(entityManager: self)
        }
        else{
            wander = Wander(entityManager: self, messages: messages, loopMessagesOn: loopOn,warningMsgs: warningMsgs)
        }
        if let sNode = wander.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: -840...840,y: -640...640)
            sNode.zRotation = CGFloat.random(in: 0...360)
            sNode.zPosition = 3
            self.add(entity: wander)
            return sNode
        }
        return nil
    }

    @discardableResult
    func loadStoryTeller(storyToTell: [String]) -> SKNode?{
        let storyTeller: StoryTeller
        // STATIC UNIT
        storyTeller = StoryTeller(entityManager: self, storyToTell: storyToTell)
        if let sNode = storyTeller.component(ofType: SpriteComponent.self)?.node{
            sNode.position = CGPoint.randomPosition(x: -10...10,y: -10...10)
            sNode.zRotation = CGFloat(0)
            sNode.zPosition = 3
            self.add(entity: storyTeller)
            return sNode
        }
        return nil
    }
    
}
