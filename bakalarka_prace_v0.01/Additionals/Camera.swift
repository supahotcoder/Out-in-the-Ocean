//
//  Camera.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 25/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

extension SKCameraNode {
    func cameraMovementWithin(Within boundaries: SKSpriteNode,CameraFocusOn focusedNode: SKSpriteNode, durationOfCameraMovement duration: TimeInterval) {
        let left : CGFloat = -boundaries.frame.width / 2 + self.scene!.size.width / 2
        let right : CGFloat = -left
        let bottom : CGFloat = -boundaries.frame.height / 2 + self.scene!.size.height / 2
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
        self.run(SKAction.move(to: position, duration: duration))
    }
}
