//
//  ContactComponent.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 11/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class ContactComponent: GKComponent {
    
    init(entity : GKEntity , bitmask: UInt32 , dynamicObject dynamic: Bool,canRotate rotation: Bool) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self) {
            let physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.node.size.height)
            physicsBody.categoryBitMask = bitmask
            // přidá kolize se všemi entitami které reagují na kontakt
            for i in bitmasks.allCases{
                physicsBody.contactTestBitMask |= i.rawValue
                physicsBody.collisionBitMask |= i.rawValue
            }
            physicsBody.isDynamic = dynamic
            physicsBody.allowsRotation = rotation
            
            physicsBody.friction = 0.2
            physicsBody.restitution = 1
            physicsBody.linearDamping = 1
            physicsBody.angularDamping = 0.7
            
            //defeaultně bude false
            physicsBody.affectedByGravity = false
            //nastaví vytovřený physics body do raálného physics body
            spriteNode.node.physicsBody = physicsBody
        }
         super.init()
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
