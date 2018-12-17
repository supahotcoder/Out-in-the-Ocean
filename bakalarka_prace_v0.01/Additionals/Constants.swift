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

let playerTexture = SKTexture(imageNamed: "player_test")

