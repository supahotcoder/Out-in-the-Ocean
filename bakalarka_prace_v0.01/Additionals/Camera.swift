//
//  Camera.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

// Rozsireni kamery, ktera se pohybuje v nastavenem oraniceni a muze se zamerovat na ruzne uzly
extension SKCameraNode {

    func generateMovementAction(within boundaries: SKSpriteNode,cameraFocusOn focusedNode: SKNode, durationOfMovement duration: TimeInterval, waitTime: TimeInterval = 0) -> SKAction {
        //  generovani akci pro pohyb kamery
        let left : CGFloat = -boundaries.frame.width / 2 + (self.scene!.size.width / 2) * self.xScale
        let right : CGFloat = -left
        let bottom : CGFloat = -boundaries.frame.height / 2 + (self.scene!.size.height / 2) * self.yScale
        let top : CGFloat = -bottom
        
        var position : CGPoint = focusedNode.position
        
        if position.x <= left {
            position.x = left
        }
        else if position.x >= right {
            position.x = right
        }
        if position.y >= top {
            position.y = top
        }
        else if position.y <= bottom {
            position.y = bottom
        }
        if waitTime == 0{
            return SKAction.move(to: position, duration: duration)
        }else{
            return SKAction.sequence([SKAction.move(to: position, duration: duration),SKAction.wait(forDuration: waitTime)])
        }
    }
    
    
    func movement(within boundaries: SKSpriteNode,cameraFocusOn focusedNode: SKNode, durationOfMovement duration: TimeInterval, waitTime: TimeInterval = 0) {
        //  pohyb kamery
        self.run(generateMovementAction(within: boundaries, cameraFocusOn: focusedNode, durationOfMovement: duration, waitTime: waitTime))
    }
    
    func scaleFor(device: UIUserInterfaceIdiom) {
    // skalovani kamery pro odlisne Apple zarizeni
        switch device {
        case .phone:
            setScale(1)
        case .pad:
            setScale(2)
        default:
            break
        }
    }
}
