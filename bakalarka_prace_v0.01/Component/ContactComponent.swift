//
//  ContactComponent.swift
//
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
            ContactComponent.addCollisions(physicsBody: physicsBody, bitmask: bitmask)
            physicsBody.isDynamic = dynamic
            physicsBody.allowsRotation = rotation
            
            if mass != 0{
                physicsBody.mass = mass
            }
            physicsBody.friction = 0.2
            physicsBody.restitution = 1
            physicsBody.linearDamping = 1
            physicsBody.angularDamping = 0.7
            
            //defaultně bude false
            physicsBody.affectedByGravity = false
            //nastaví vytovřený physics body do reálného physics body
            spriteNode.node.physicsBody = physicsBody
        }
         super.init()
  
    }

    static func addCollisions(physicsBody: SKPhysicsBody, bitmask: UInt32) {
        physicsBody.categoryBitMask = bitmask
        // přidá kolize se všemi entitami které reagují na kontakt
        for i in bitmasks.allCases{
            physicsBody.contactTestBitMask |= i.rawValue
            physicsBody.collisionBitMask |= i.rawValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
