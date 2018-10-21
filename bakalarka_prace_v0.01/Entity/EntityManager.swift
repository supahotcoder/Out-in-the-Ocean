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
    
    //MARK: RE-WRITE
    
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
    
    private func loadGame() {
    //TODO:
    }
}
