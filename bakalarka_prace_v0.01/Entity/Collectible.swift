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
    
    init(texture tx: String, size: CGSize, id: String, protectable: Bool = false ,entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        let texture = SKTexture(imageNamed: tx)
        let spriteComp = SpriteComponent(entity: self, texture: texture, size: size)
        self.addComponent(spriteComp)
        
        //TESTING
        spriteComp.node.position = CGPoint(x: Int.random(in: 0...840) - Int.random(in: 0...840), y: Int.random(in: 0...640) - Int.random(in: 0...640))
        
        //ID for later removal
        spriteComp.node.name = id
        
        //dopíči včera to byla mordor párty, zaspal jsem první vlak abych jel k zubařce
        //tak jedu druhým bez rezervace a sedím tu s random lidmi a úplně namrdaný
        //nikdy jsem nečekal, že bych tak moc ocenil vodu kterou kurva NEMÁM
        //doufám že v Ostravě mají kromě uhlí taky vodu nebo tu asi zdechnu
        //teďka tady předstírám že dělám na bakalářce, ale naštěstí nevidím na klávesnici
        //proto tu píšu random koment o včerejšku, jestli tu dneska nepojdu, tak budu bakalář
        //no do píčí, vůbec mi není dobře
        //zatím to nevypadá vůbec přívětivě, taky celkem vtipné že jsem pořád schopný
        //vymyslet česká slova, které vypadají profi a spisovně
        //teďka odešli spolucestující, kteří tu mají pořád věci, asi museli odvést svého syna,
        //který absorboval moje výpary a je na mol, stěstí že jsem se ráno neviděl v zrcadle
        //asi bych si zakázal vůbec vyjít z pokoje
        
        let contactComp = ContactComponent(entity: self, bitmask: bitmasks.collectible.rawValue, dynamicObject: true, canRotate: true)
        self.addComponent(contactComp)
        
        let moveComp = MoveComponent(maxSpeed: 0, maxAcceleration: 0, effectiveRadius: Float(spriteComp.node.size.width), entityManager: entityManager)
        addComponent(moveComp)
        
        if protectable{
            let protectComp = ProtectComponent()
            addComponent(protectComp)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
