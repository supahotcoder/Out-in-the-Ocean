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
        
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(color: UIColor.black, size: CGSize.init(width: 5000, height: 5000))
        self.name = "Level0"
        playerSpawnPosition = CGPoint(x: (self.scene?.position.x)!,y: (self.scene?.position.y)!)
        
        super.didMove(to: view)
        
        //        MUSIC SETUP
        backgroundMusic(fileName: "level0-sound", extension: "wav")
        
        // Smog effect
        let smogBack = SKEmitterNode(fileNamed: "SmogEffect")!
        let smogFront = SKEmitterNode(fileNamed: "SmogEffect")!
        let backgroundRange = CGVector(dx: (background?.frame.width)!, dy: (background?.frame.height)!)
        smogBack.particlePositionRange = backgroundRange
        smogFront.particlePositionRange = backgroundRange
        
        smogBack.position = CGPoint(x: 0,y: 0)
        smogFront.position = CGPoint(x: 0,y: 0)
        smogFront.zPosition = 3
        self.addChild(smogFront)
        self.addChild(smogBack)
        
        // FUNCTIONS WRAPPED TO VOID FUNCTION WITH NO PARAMS SO IT CAN BE USED IN BACKGROUND THREAD TO RUN
        let f1Wrapped = {() in self.updateStoryText(with: "On your left a joystick will be shown", around: self.playerNode!,displayIn: 0, fadeOut: 1, timeToFocusOn: 5,forDuration: 3)}
        let f2Wrapped =  {() in self.updateStoryText(with: "Use it for movement", around: self.playerNode!,displayIn: 0.5, fadeOut: 1, timeToFocusOn: 0)}

        runInBackground(delay: 4, function: f1Wrapped, completion: f2Wrapped)

//        waitAndRun(delay: 6, function: {() in self.nextLevel()})
        
        waitAndRun(delay: 15, function: {() in self.updateStoryText(with: "Try to find some clues", around: self.playerNode!,displayIn: 0.5, fadeOut: 1, timeToFocusOn: 3)})
        waitAndRun(delay: 35, function: {() in self.updateGoalText(with: "Can't find any?", around: self.playerNode!)})
        waitAndRun(delay: 45, function: {() in self.updateGoalText(with: "Don't worry there weren't any", around: self.playerNode!)})
        waitAndRun(delay: 55, function: {() in self.updateGoalText(with: "I've told you to try, I haven't told you there are going to be any", around: self.playerNode!)})
        waitAndRun(delay: 75, function: {() in self.updateGoalText(with: "... ... ...", around: self.playerNode!)})
        waitAndRun(delay: 85, function: {() in self.updateGoalText(with: "This world is full of clues and hidden meanings, or isn't it?", around: self.playerNode!)})
        waitAndRun(delay: 95, function: {() in self.updateStoryText(with: "Okay enough of the introduction...", around: self.playerNode!,displayIn: 0.5, fadeOut: 1, timeToFocusOn: 15)})
        
        waitAndRun(delay: 100, function: { () in self.runInBackground(delay: 15, function: {() in self.updateGoalText(with: "Let's begin", around: self.playerNode!)}, completion: {() in self.nextLevel()})})
       
    }
    
    func nextLevel(){
        if let scene = SKScene(fileNamed: "Level1_1") {
            self.removeAllActions()
            joystickNode?.removeAllChildren()
            joystickNode?.removeFromParent()
            saveLevel(levelName: "Level1_1")
            let warp = SKEmitterNode(fileNamed: "Warping")!
            let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
            warp.position = playerNode!.position
            warp.zPosition = 2
            self.addChild(warp)
            warp.run(removeWarp)
            waitAndRun(delay: 0.5, function: {() in
                self.playerNode?.run(SKAction.fadeOut(withDuration: 1), completion: {
                    self.scene?.run(SKAction.colorize(with: UIColor.init(red: 110/255, green: 230/255, blue: 160/255, alpha: 1), colorBlendFactor: 0.9, duration: 3))
                               self.scene?.run(SKAction.fadeOut(withDuration: 2.5), completion: {
                                   self.removeAllActions()
                                   self.removeAllChildren()
                                   self.view?.presentScene(scene)
                               })
                })
            })
            
        }
    }
 
    func gameOver() {}
    
    func didBegin(_ contact: SKPhysicsContact){}
}
