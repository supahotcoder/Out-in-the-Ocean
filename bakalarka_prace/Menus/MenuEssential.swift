//
//  MenuEssential.swift
//  bakalarka_prace_v0.01
//
//  Created by Jan Czerny on 24/02/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class MenuEssential: SKScene {
    
     var backgroundMusicPlayer: AVAudioPlayer?

    
    func touchAnimation(position: CGPoint) {
        let warp = SKEmitterNode(fileNamed: "Warping")
        warp?.zPosition = 4
        warp?.position = position
        self.addChild(warp!)
        let remove = SKAction.sequence([SKAction.wait(forDuration: 5),SKAction.removeFromParent()])
        warp?.run(remove)
    }
    
    func buttonPressed(node: SKSpriteNode) {
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        node.run(SKAction.sequence([fadeOut,fadeIn]))
    }
}
