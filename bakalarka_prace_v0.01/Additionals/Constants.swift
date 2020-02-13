//
//  Constants.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 11/10/6018.
//  Copyright © 6018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

enum bitmasks : UInt32 , CaseIterable {
   // case boundaries = 0b0
    case player = 0b1
    case activeBackground = 0b10
    case frame = 0b11
    case camera = 0b100
    case searcher = 0b101
    case wander = 0b110
    case collectible = 0b111
    case storyTeller = 0b1000
}

enum position  {
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
    case onEntity
    
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
        case .onEntity:
            return CGPoint(x: 50, y: -40)
}
    }
}

func displayText(displayIn: TimeInterval,fadeOut: TimeInterval, label: SKLabelNode, around: SKNode, alligment: position=position.leftBottom, forDuration: TimeInterval?=nil){
    let showForDur = forDuration ?? TimeInterval((label.text?.count)! / 5)
    label.run(SKAction.sequence([SKAction.wait(forDuration: displayIn),SKAction.run{label.trackNode(node: around,labelAlligment: alligment.toCGPoint)},SKAction.fadeIn(withDuration: 0.3),
                                 SKAction.wait(forDuration: showForDur),SKAction.fadeOut(withDuration: fadeOut), SKAction.removeFromParent()]))
}

func deviceAdjustments(_ device: UIUserInterfaceIdiom, _ screen: CGRect) -> CGFloat {
    var size: CGFloat = 1
    switch device {
    case .pad:
        size = 2
    case .phone:
        if (screen.width + screen.height) < 6000{
            size = 2.3
        }
    default:
        break
    }
    return size
}
