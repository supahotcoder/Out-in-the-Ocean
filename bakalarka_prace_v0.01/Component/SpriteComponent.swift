//
//  SpriteComponent.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent{
    
    //MARK: - RE-WRITE
    
   let node : SKSpriteNode
    
    init(entity: GKEntity,texture: SKTexture,size: CGSize) {
        node = SKSpriteNode(texture: texture, color: .white, size: size)
        node.entity = entity
        super.init()
    }

//    use this innit only in difficult situations with swift compiler
    override init() {
        node = SKSpriteNode(imageNamed: "transp")
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
