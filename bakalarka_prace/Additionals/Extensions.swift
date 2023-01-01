//
//  Extensions.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public func asArray() -> [T]{
        return array
    }
    
    public var last: T? {
        return array.last
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}

extension SKLabelNode{
    // pro zobrazování textu poblíž node
    func trackNode(node: SKNode,labelAlligment: CGPoint = CGPoint(x: 0, y: 0)) {
        let randPos  = CGPoint(x: Int.random(in: 0...30) - Int.random(in: 0...30),
                               y: Int.random(in: 0...30) - Int.random(in: 0...30)) + labelAlligment
        self.position = node.position + randPos
    }
    
}

// Převody a pár funkcí pro práci s automaticky navigovanými NPC
extension CGVector{
    static prefix func -(left: CGVector) -> CGVector{
        return CGVector(dx: -left.dx, dy: -left.dy)
    }
    
    func speed() -> CGFloat{
        return sqrt(dx * dx + dy * dy)
    }
    func angle() -> CGFloat {
        return atan2(dy, dx)
    }
    static func >(left: CGVector ,right: CGVector) -> Bool {
        if left.dx <= right.dx , left.dy <= right.dy {
            return false
        }
        else{
            return true
        }
    }
    static func <(left: CGVector ,right: CGVector) -> Bool {
        if left.dx >= right.dx , left.dy >= right.dy {
            return false
        }
        else{
            return true
        }
    }
    static func ==(left: CGVector ,right: CGVector) -> Bool {
        if left.dx != right.dx , right.dy != left.dy {
            return false
        }
        else{
            return true
        }
    }
    
    static func >=(left: CGVector ,right: CGVector) -> Bool {
        if  left > right || left == right{
            return true
        }
        else{
            return false
        }
    }
    static func <=(left: CGVector ,right: CGVector) -> Bool {
        if  left < right || left == right{
            return true
        }
        else{
            return false
        }
    }
}

extension vector_float2{
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

    private static func avoidNode(x: ClosedRange<Int>, y: ClosedRange<Int>, nodeToAvoid: SKSpriteNode, xBodySizesFromNode: CGFloat, maxDepth: Int = 100, currDepth: Int) -> CGPoint {
        let randomPos: CGPoint = randomPosition(x: x, y: y)
        if (randomPos - nodeToAvoid.position).length() > max(nodeToAvoid.size.width, nodeToAvoid.size.width) * xBodySizesFromNode {
            return randomPos
        } else if currDepth == maxDepth {
            return randomPos
        } else {
            return avoidNode(x: x, y: y, nodeToAvoid: nodeToAvoid, xBodySizesFromNode: xBodySizesFromNode, maxDepth: maxDepth, currDepth: currDepth + 1)
        }
    }

    static func randomPositionAvoidNode(x: ClosedRange<Int>,y: ClosedRange<Int>, nodeToAvoid: SKSpriteNode, maxDepth: Int = 100, xBodySizesFromNode: Int = 2) -> CGPoint {
        return avoidNode(x: x, y: y, nodeToAvoid: nodeToAvoid, xBodySizesFromNode: CGFloat(xBodySizesFromNode), maxDepth: maxDepth, currDepth: 0)
    }
    
    static func randomPosition(x: ClosedRange<Int>,y: ClosedRange<Int>) -> CGPoint {
        let x = GKRandomDistribution(randomSource: GKRandomSource.sharedRandom(),lowestValue: x.lowerBound, highestValue: x.upperBound).nextInt()
        let y = GKRandomDistribution(randomSource: GKRandomSource.sharedRandom(),lowestValue: y.lowerBound, highestValue: y.upperBound).nextInt()
        return .init(x: x, y: y)
    }
    
    init(tuple: (x: Double,y: Double)) {
        self.init()
        self.x = CGFloat(tuple.x)
        self.y = CGFloat(tuple.y)
    }
    
    func isInsideRange(position: CGPoint, rangeSize: CGFloat) -> Bool{
           return self.x < position.x + rangeSize && self.x > position.x - rangeSize &&
           self.y < position.y + rangeSize && self.y > position.y - rangeSize
       }

    static prefix func -(value: CGPoint) -> CGPoint{
        return CGPoint(x: -value.x, y: -value.y)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGVector {
        return  CGVector(dx: left.x - right.x, dy: left.y - right.y)
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
 
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    func floatConvetor() -> (x: Float,y: Float){
        return (x: Float(self.x), y: Float(self.y))
    }
}

extension CGVector{
    static func - (left: CGVector, right: CGVector) -> CGVector {
        return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
    }
}

extension CGSize{
    static func / (left: CGSize, right: Double) -> CGSize {
        return CGSize(width: left.width / CGFloat(right), height: left.height / CGFloat(right))
    }
}
