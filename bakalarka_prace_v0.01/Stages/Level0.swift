//
//  Level0.swift
//  bakalarka_prace_v0.01
//
//  Created by Jan Czerny on 10/02/2020.
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation



class Level0: GameScene {
    
//    TODO: ADD ONE THREAD TO DO WAIT SOME ACTION WHILE NOT STOPPING GAME
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(color: UIColor.black, size: CGSize.init(width: 1000, height: 1000))
        self.name = "Level0"
        playerSpawnPosition = CGPoint(x: (self.scene?.position.x)!,y: (self.scene?.position.y)!)
        
        super.didMove(to: view)
        // FUNCTIONS WRAPPED TO VOID FUNCTION WITH NO PARAMS SO IT CAN BE USED IN BACKGROUND THREAD TO RUN
        let f1Wrapped = {() in self.updateStoryText(with: "On your left a joystick will be shown", around: self.playerNode!,displayIn: 0, fadeOut: 1, timeToFocusOn: 2.5)}
        let f2Wrapped =  {() in self.updateStoryText(with: "Use it for movement", around: self.playerNode!,displayIn: 3, fadeOut: 1, timeToFocusOn: 2)}
        f1Wrapped()
        f2Wrapped()
        
//        runInBackground(delay: 3, function: f1Wrapped, completion: f2Wrapped)

        
    }
 
    func gameOver() {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    
    
}
