//
//  Constants.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 11/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

enum bitmasks : UInt32 , CaseIterable {
    case player = 0b1
    case activeBackground = 0b10
    case frame = 0b11
    case camera = 0b100
    case searcher = 0b101
    case wander = 0b110
    case collectible = 0b111
}

enum position  {
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
    
    var toCGPoint: CGPoint{
        switch self {
        case .leftTop:
            return CGPoint(x: -60, y: 60)
        case .leftBottom:
            return CGPoint(x: -60, y: -60)
        case .rightTop:
            return CGPoint(x: 60, y: 60)
        case .rightBottom:
            return CGPoint(x: 60, y: -60)
        }
    }
}

func displayText(displayIn: TimeInterval,fadeOut: TimeInterval, label: SKLabelNode){
    label.run(SKAction.sequence([SKAction.wait(forDuration: displayIn),SKAction.fadeIn(withDuration: displayIn / 2),
                                 SKAction.wait(forDuration: TimeInterval((label.text?.count)! / 5)),SKAction.fadeOut(withDuration: fadeOut), SKAction.removeFromParent()]))
}

let playerTexture = SKTexture(imageNamed: "player_test")

func wanderBody(node: SKSpriteNode) -> SKPhysicsBody {
    let sprite = node
    let offsetX = sprite.size.width * sprite.anchorPoint.x
    let offsetY = sprite.size.height * sprite.anchorPoint.y
    let w = 5
    let path = CGMutablePath()
    path.move(to: CGPoint(x: CGFloat(228 / w) - offsetX,y: CGFloat(44 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(136 / w) - offsetX,y: CGFloat(235 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(86 / w) - offsetX,y: CGFloat(280 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(36 / w) - offsetX,y: CGFloat(397 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(84 / w) - offsetX,y: CGFloat(500 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(360 / w) - offsetX,y: CGFloat(560 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(462 / w) - offsetX,y: CGFloat(521 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(559 / w) - offsetX,y: CGFloat(500 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(530 / w) - offsetX,y: CGFloat(302 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(461 / w) - offsetX,y: CGFloat(233 / w) - offsetY))
    path.addLine(to: CGPoint(x: CGFloat(428 / w) - offsetX,y: CGFloat(86 / w) - offsetY))
    path.closeSubpath()
    return SKPhysicsBody(polygonFrom: path)
}


