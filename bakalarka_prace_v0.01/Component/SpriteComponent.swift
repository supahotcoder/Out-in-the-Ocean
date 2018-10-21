//
//  SpriteComponent.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 08/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent{
    
    //MARK: RE-WRITE
    
   let node : SKSpriteNode
    
    init(entity: GKEntity,texture: SKTexture,size: CGSize) {
        node = SKSpriteNode(texture: texture, color: .white, size: size)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
