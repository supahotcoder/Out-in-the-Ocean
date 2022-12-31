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
    
    private var startDate: Date?
    
    private var isChangingLevel: Bool = false
    private var didFinishStory: Bool = false
        
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(color: .lightGray, size: CGSize(width: 30000, height: 30000))
        self.name = "Level0"
        let edgePhysicsBody = SKPhysicsBody(edgeLoopFrom: (background?.frame)!)
        self.physicsBody = edgePhysicsBody
        
        playerSpawnPosition = CGPoint(x: (self.scene?.position.x)!,y: (self.scene?.position.y)!)
        
        super.didMove(to: view)
        //        HELP SETUP
        helpBox = HelpBox(levelName: "level0")
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
        if joystick.isDynamic{
            self.updateStoryText(with: "By pressing anywhere on display a joystick will be shown", around: self.playerNode!, fadeOut: 1)
        }else{
            self.updateStoryText(with: "On your left a joystick will be shown", around: self.playerNode!, fadeOut: 1)
        }
        self.updateStoryText(with: "Use it for movement", around: self.playerNode!, fadeOut: 1)
        self.updateStoryText(with: "Of course the joystick is working,\nyou just need to wait until I finish this introduction.", around: self.playerNode!, fadeOut: 1)
        self.updateStoryText(with: "You can always change the joystick in the settings.", around: self.playerNode!)
        self.updateStoryText(with: "Settings can be found in main menu and pause menu.", around: self.playerNode!)
        self.updateStoryText(with: "In the pause menu you can always find some help.", around: self.playerNode!)
        self.updateStoryText(with: "Interaction with entities could be done by colliding with them.\nSome might kill you and some may give you tips.", around: self.playerNode!)
        self.updateStoryText(with: "Particular interactions might trigger player thoughts.\nThey are shown as a text in black background.", around: self.playerNode!)
        startDate = Date()
        self.updateStoryText(with: "Try to find some clues", around: self.playerNode!,displayIn: 0.5, fadeOut: 1, forDuration: 1)
        self.updateGoalText(with: "Can't find any?", around: self.playerNode!, displayIn: 60)
        self.updateGoalText(with: "Don't worry there weren't any", around: self.playerNode!, displayIn: 65)

    }
    
    func nextLevel(){
        changingLevel = true
        let nextlevel = "Level0_1"
        self.removeAllActions()
        joystickNode?.removeAllChildren()
        joystickNode?.removeFromParent()
        saveLevel(levelName: nextlevel)
        let warp = SKEmitterNode(fileNamed: "Warping")!
        let removeWarp = SKAction.sequence([SKAction.wait(forDuration: 5), SKAction.removeFromParent()])
        warp.position = playerNode!.position
        warp.zPosition = 2
        self.addChild(warp)
        warp.run(removeWarp)
        waitAndRun(delay: 0.5, function: { () in
            self.playerNode?.run(SKAction.fadeOut(withDuration: 1), completion: {
                self.scene?.run(SKAction.colorize(with: UIColor.init(red: 110 / 255, green: 230 / 255, blue: 160 / 255, alpha: 1), colorBlendFactor: 0.9, duration: 3))
                self.scene?.run(SKAction.fadeOut(withDuration: 2.5), completion: {
                    if let scene = SKScene(fileNamed: nextlevel) {
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(scene)
                    }
                })
            })
        })
    }
 
    func gameOver() {}
    
    func didBegin(_ contact: SKPhysicsContact){}
    
    override func update(_ currentTime: TimeInterval) {
        if -(startDate?.timeIntervalSinceNow ?? 0) > 60 + totalTimeInMenu, !didFinishStory{
            self.updateStoryText(with: "I've told you to try, I haven't told you there are going to be any", around: self.playerNode!, forDuration: 3)
            self.updateStoryText(with: "....", around: self.playerNode!, forDuration: 0.5)
            self.updateStoryText(with: "This world is full of clues and hidden meanings, or isn't it?", around: self.playerNode!, forDuration: 2.4)
            self.updateStoryText(with: "Okay enough of the introduction...", around: self.playerNode!, fadeOut: 1, forDuration: 1)
            didFinishStory = true
        }
        
        super.update(currentTime)
        
        if -(startDate?.timeIntervalSinceNow ?? 0) > 85 + totalTimeInMenu, !isChangingLevel{
            isChangingLevel = true
            nextLevel()
        }
    }
}
