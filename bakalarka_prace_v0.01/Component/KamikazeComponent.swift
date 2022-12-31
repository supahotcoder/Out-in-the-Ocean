//
// Created by Janko on 29.12.2022.
// Copyright (c) 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class KamikazeComponent: GKComponent {

    private let node : SKSpriteNode
    private let  extraCooldown: Double
    private(set) var lastKamikazeTime: Date
    private(set) var cooldownTime: TimeInterval
    private var isKamikazeTime: Bool
    private var skewDirectionBy: CGPoint?

    init(node: SKSpriteNode, skewDirectionBy skew: CGPoint? = nil, extraCooldown coolDown: Double = 5) {
        self.node = node
        lastKamikazeTime = Date()
        cooldownTime = 0
//        "prvni naboj" pouziva se pro spravne nastaveni MoveSettings (po kamikaze se entita regeneruje)
        isKamikazeTime = true
        skewDirectionBy = skew
        extraCooldown = coolDown
        super.init()
    }

    convenience init(node: SKSpriteNode, skewDirectionBy skew: CGPoint) {
        self.init(node: node)
        skewDirectionBy = skew
    }

    func kamikaze(toNode: SKNode,wait: Double = 0.5, kamikazeTime: Double = 3.5) {
        lastKamikazeTime = Date()
        cooldownTime = wait + kamikazeTime + extraCooldown
        isKamikazeTime = false
        if var skew = skewDirectionBy{
            skew = GKRandomSource.sharedRandom().nextBool() ? skew : -skew
            let destination: CGPoint = toNode.position - skew
            node.run(SKAction.sequence([.rotate(byAngle: 180, duration: 1),.wait(forDuration: wait),.applyImpulse((destination - node.position), duration: kamikazeTime)]))
        }else{
            node.run(SKAction.sequence([.rotate(byAngle: 180, duration: 1),.wait(forDuration: wait),.applyImpulse((toNode.position - node.position), duration: kamikazeTime)]))
        }
    }

    func isKamikazeFinished()-> Bool{
        canKamikazeAgain()
        return isKamikazeTime
    }

    @discardableResult
    func canKamikazeAgain() -> Bool {
        let canKamikaze = -lastKamikazeTime.timeIntervalSinceNow > cooldownTime
        if canKamikaze{
            isKamikazeTime = true
        }
        return canKamikaze
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
