//
//  Extensions.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 12/11/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

// TODO: - Add camera extension

extension float2{
    func doubleConvetor() -> (x: Double,y: Double){
        return (x: Double(self.x), y: Double(self.y))
    }
    
    init(tuple: (x: Float,y: Float)) {
        self.init()
        self.x = tuple.x
        self.y = tuple.y
    }
}

extension CGPoint{
    init(tuple: (x: Double,y: Double)) {
        self.init()
        self.x = CGFloat(tuple.x)
        self.y = CGFloat(tuple.y)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    func floatConvetor() -> (x: Float,y: Float){
        return (x: Float(self.x), y: Float(self.y))
    }
}
