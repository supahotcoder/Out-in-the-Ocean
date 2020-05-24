//
//  Collectible.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 14/02/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class Collectible: GKEntity {
    
    let entityManager: EntityManager
    private(set) var collected: Bool
    private(set) var spriteComp: SpriteComponent

    init(texture tx: String, size: CGSize, id: String, protectable: Bool = false ,entityManager: EntityManager, location: CGPoint? = nil) {
        self.entityManager = entityManager
        collected = false
//       using this approach to avoid using Optional as we are initializing spriteComp later on using self
        spriteComp = SpriteComponent()
        super.init()
        let texture = SKTexture(imageNamed: tx)
        spriteComp = SpriteComponent(entity: self, texture: texture, size: size)
        self.addComponent(spriteComp)

        if location == nil{
        spriteComp.node.position = CGPoint(x: Int.random(in: 0...840) - Int.random(in: 0...840), y: Int.random(in: 0...640) - Int.random(in: 0...640))
        }else{
            spriteComp.node.position = location!
        }
        
        //ID for later removal out of Scene
        spriteComp.node.name = id
        
        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.collectible.rawValue, dynamicObject: true, canRotate: true)
        self.addComponent(contactComp)
        
        let moveComp = MoveComponent(maxSpeed: 0, maxAcceleration: 0, effectiveRadius: Float(spriteComp.node.size.width), entityManager: entityManager)
        addComponent(moveComp)
        
        if protectable{
            let protectComp = ProtectComponent()
            addComponent(protectComp)
        }
    }

    func collect(){
        entityManager.remove(entity: self)
        collected = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
