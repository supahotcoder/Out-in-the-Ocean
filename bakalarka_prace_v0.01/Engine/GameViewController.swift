//
//  GameViewController.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            // Load the SKScene from 'GameS@objc @objc cene.sks'
            if let scene = SKScene(fileNamed: "MainMenu") {

                // Set the scale mode to scale to fit the window
                if UIDevice.current.userInterfaceIdiom == .pad{
                    scene.scaleMode = .resizeFill
                }
                else{
                    scene.scaleMode = .fill
                }
                // Present the scene
                view.presentScene(scene)
            }
            
            //test
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsDrawCount = true // pro pozdější optimalizaci
            view.showsPhysics = true
//            view.showsFields = true
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
