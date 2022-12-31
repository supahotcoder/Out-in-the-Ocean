//
//  Game.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import GameplayKit
import SpriteKit

class EntityManager {
    
    private(set) var gameEntities = Set<GKEntity>()
    
    private(set) var scene : GameSceneClass? // možná se bude měnit podle levelu, proto var
    
    private(set) var player: GKEntity? = nil
    
    private(set) var enemies = Set<GKEntity>()
    
    var gameOver = false
    
     init(scene: GameSceneClass) {
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

    func giveFeedback(text: String, around: SKSpriteNode) -> SKLabelNode?{
        if !gameOver{
            return scene?.updateFeedbackText(with: text, around: around)
        }
        return nil
    }

    func tellStory(text: String, around: SKNode,fadeIn: TimeInterval, fadeOut: TimeInterval) -> SKLabelNode? {
        if !gameOver{
            let timeUntilNextText = TimeInterval(text.count / Int(TEXT_SPEED)) + fadeIn + fadeOut + 1.0
            return scene?.updateStoryText(with: text, around: around, fadeIn: fadeIn, fadeOut: fadeOut,forDuration: timeUntilNextText - fadeIn - fadeOut - 0.5)
        }
        return nil
    }

    func getEntityFromNode(node: SKNode) -> [GKEntity]{
        return gameEntities.filter { entity in entity.component(ofType: SpriteComponent.self)?.node.name == (node as? SKSpriteNode)?.name}
    }

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

    func remove(entityNodeName: String) {
        let entity = findEntity(entityNodeName: entityNodeName)
        if let ent =  entity{
            remove(entity: ent)
        }
    }

     func findEntity(entityNodeName: String) -> GKEntity? {
        gameEntities.filter { (entity: GKEntity) -> Bool in entity.component(ofType: SpriteComponent.self)?.node.name == entityNodeName }.first
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
    func loadSearcher(positionTo: CGPoint? = nil, imageNamed: String) -> SKNode?{
        let searcher = Searcher(imageName: imageNamed, entityManager: self)
        if let sNode = searcher.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: 100...840,y: -640...640)
            if let posSpawn = positionTo{
                sNode.position = posSpawn
            }
            sNode.zPosition = 3
            self.add(entity: searcher)
            return sNode
        }
        enemies.insert(searcher)
        return nil
    }

    @discardableResult
    func loadKamikazer(positionTo: CGPoint? = nil, imageNamed: String, skewDirectionBy: CGPoint? = nil, extraCooldown: Double? = nil) -> SKNode?{
        let kamikazer = Kamikazer(imageName: imageNamed, entityManager: self, skewDirectionBy: skewDirectionBy, extraCooldown: extraCooldown)
        if let sNode = kamikazer.component(ofType: SpriteComponent.self)?.node {
            sNode.position = CGPoint.randomPosition(x: 100...840,y: -640...640)
            if let posSpawn = positionTo{
                sNode.position = posSpawn
            }
            sNode.zPosition = 3
            self.add(entity: kamikazer)
            return sNode
        }
        enemies.insert(kamikazer)
        return nil
    }
    
    func loadActiveBackground(imageName: String, position: CGPoint? = nil) -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: imageName,entityManager: self)
        if let acNode = activeBack.component(ofType: SpriteComponent.self)?.node {
            acNode.position = CGPoint.randomPosition(x: -840...840,y: -640...640)
            if let pos = position{
                acNode.position = pos
            }
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
    func loadWarper(shouldSpin: Bool = true, imageNamed: String = "spin") -> ActiveBackground? {
        let activeBack = ActiveBackground(imageName: imageNamed,entityManager: self)
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
    func loadWander(messages: [String] = [""], imageName: String = "wander", loopOn: Int? = nil, warningMsgs: [String] = [""], position: CGPoint, rotation: CGFloat=CGFloat.random(in: 0..<360)) -> SKNode? {
        let wander: Wander
        if messages == [""]{
            wander = Wander(imageName: imageName, entityManager: self)
        }
        else{
            wander = Wander(imageName: imageName, entityManager: self, messages: messages, loopMessagesOn: loopOn, warningMsgs: warningMsgs)
        }
        if let sNode = wander.component(ofType: SpriteComponent.self)?.node {
            sNode.position = position
            sNode.zRotation = rotation
            sNode.zPosition = 3
            self.add(entity: wander)
            return sNode
        }
        return nil
    }

    @discardableResult
    func loadStoryTeller(storyToTell: [String],completion: (() -> ())? = nil, imageNamed: String, triggerable: Bool, position: CGPoint, rotation: CGFloat = 0) -> (entity: StoryTeller?, node: SKSpriteNode?) {
        let storyTeller: StoryTeller
        // STATIC UNIT
        storyTeller = StoryTeller(entityManager: self, storyToTell: storyToTell, triggerable: triggerable,completion: completion, imageNamed: imageNamed)
        if let sNode = storyTeller.component(ofType: SpriteComponent.self)?.node{
            sNode.position = position
            sNode.zRotation = rotation
            sNode.zPosition = 3
            self.add(entity: storyTeller)
            return (storyTeller, sNode)
        }
        return (nil, nil)
    }
    
}
