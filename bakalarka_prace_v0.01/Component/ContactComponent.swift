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
    
    init(entity : GKEntity , bitmask: UInt32 , dynamicObject dynamic: Bool,canRotate rotation: Bool, pathBody: SKPhysicsBody? = nil, mass: CGFloat=0) {
        if let spriteNode = entity.component(ofType: SpriteComponent.self) {
            var physicsBody = SKPhysicsBody(circleOfRadius: spriteNode.node.size.width / 2)
            
            if (pathBody != nil) {
                physicsBody = pathBody!
            }
            physicsBody.categoryBitMask = bitmask
            // přidá kolize se všemi entitami které reagují na kontakt
            for i in bitmasks.allCases{
                physicsBody.contactTestBitMask |= i.rawValue
                physicsBody.collisionBitMask |= i.rawValue
            }
            physicsBody.isDynamic = dynamic
            physicsBody.allowsRotation = rotation
            
            if mass != 0{
                physicsBody.mass = mass
            }
            physicsBody.friction = 0.2
            physicsBody.restitution = 1
            physicsBody.linearDamping = 1
            physicsBody.angularDamping = 0.7
            
            //defeaultně bude false
            physicsBody.affectedByGravity = false
            //nastaví vytovřený physics body do reálného physics body
            spriteNode.node.physicsBody = physicsBody
        }
         super.init()
  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
