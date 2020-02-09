//
// Created by Jan Czerny on 03/11/2019.
// Copyright (c) 2019 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class DamageComponent : GKComponent {

    private(set) var damageHit : Int

    init(damageOnHit: Int) {
        damageHit = damageOnHit
        super.init()
    }

    func dealDmg(entity to: GKEntity) {
        if let  hpEn = entity?.component(ofType: HealthComponent.self){
            hpEn.takeDmg(damage: damageHit)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}