//
//  HelpBox.swift
//
//  Copyright © 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class HelpBox {

    private(set) var close: SKSpriteNode
    private(set) var active: Bool
    let helpBlackBackground: SKSpriteNode
    let helpBackground: SKSpriteNode

    init(levelName: String) {
        close = SKSpriteNode(color: .black, size: .zero);
        helpBackground = SKSpriteNode(texture: SKTexture(imageNamed: "help-" + levelName.lowercased()), size: UIScreen.main.bounds.size)
        helpBackground.zPosition = 20
        helpBackground.isHidden = true
        helpBlackBackground = SKSpriteNode(color: UIColor.darkGray, size: UIScreen.main.bounds.size)
        helpBlackBackground.zPosition = 19
        helpBlackBackground.isHidden = true
        active = false
        setUpHelpBox()
    }
    

    private func setUpHelpBox() {
        let buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: buttonSize.pauseButton.toCGSize)
        let labelBlueprint = SKLabelNode(text: "Close")
        labelBlueprint.position = CGPoint(x: 0, y: -(buttonSize.pauseButton.toCGSize.height / 9))
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        close = (buttonBlueprint.copy() as? SKSpriteNode)!
        close.position = CGPoint(x: (UIScreen.main.bounds.width / 2) - (buttonBlueprint.size.width) / 2, y: (UIScreen.main.bounds.height / 2) - (buttonBlueprint.size.height) / 2)
        close.zPosition = 21
        labelBlueprint.text = "Close"
        labelBlueprint.fontSize = 18
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)
        close.addChild(labelBlueprint.copy() as! SKLabelNode)
        close.isHidden = true
        active = false
    }

    func showHelp(parentNode: SKNode) {
        active = true
        helpBackground.isHidden = false
        helpBlackBackground.isHidden = false
        close.isHidden = false
        parentNode.addChild(helpBlackBackground)
        parentNode.addChild(helpBackground)
        parentNode.addChild(close)
    }

    private func removeHelp() {
        helpBlackBackground.removeFromParent()
        helpBackground.removeFromParent()
        close.removeFromParent()
        active = false
    }


    func didCloseHelp(touches: Set<UITouch>, touchedIn: SKNode){
        if let t = touches.first?.location(in: touchedIn) {
            if close.frame.contains(t) {
                removeHelp()
                active = false
            }
         }
    }
                 
}

