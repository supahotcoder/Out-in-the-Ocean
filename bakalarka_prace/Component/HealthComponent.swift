//
// Created by Jan Czerny on 03/11/2019.
// Copyright (c) 2019 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class HealthComponent : GKComponent {

    private(set) var healthCount: Int

     init(healthCount: Int) {
        self.healthCount = healthCount
         super.init()
    }

    @discardableResult
    func takeDmg(damage: Int) -> Bool {
        healthCount -= damage
        return isAlive()
    }

    func isAlive() -> Bool{
        return healthCount > 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}