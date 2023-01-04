//
//  DialogBox.swift
//
//  Copyright © 2020 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

//protocol DialogProtocol: GameScene{
//    var dialogOption1: SKSpriteNode? { get set }
//    var dialogOption2: SKSpriteNode? { get set }
//}

class DialogController {

    private(set) var dialogOption1: SKSpriteNode
    private(set) var dialogOption2: SKSpriteNode
    private(set) var finished: Bool
    private(set) var resolution: Int?
    private(set) var active: Bool
    let dialogBackground: SKSpriteNode


    unowned let gameScene: GameScene

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        dialogOption1 = SKSpriteNode(color: .black, size: .zero);
        dialogOption2 = SKSpriteNode(color: .black, size: .zero);
        dialogBackground = SKSpriteNode(color: .darkGray, size: UIScreen.main.bounds.size)
        dialogBackground.zPosition = 9
        dialogBackground.isHidden = true
        dialogBackground.alpha = 0.5
        finished = true
        active = false
    }

    init(gameScene: GameScene, dialog1TextAndID: (String, Int), dialog2TextAndID: (String, Int)) {
        self.gameScene = gameScene
        dialogOption1 = SKSpriteNode(color: .black, size: .zero);
        dialogOption2 = SKSpriteNode(color: .black, size: .zero);
        dialogBackground = SKSpriteNode(color: .darkGray, size: UIScreen.main.bounds.size)
        dialogBackground.zPosition = 9
        dialogBackground.isHidden = true
        dialogBackground.alpha = 0.5
        finished = false
        active = false
        setUpNewDialogs(dialog1TextAndID: dialog1TextAndID, dialog2TextAndID: dialog2TextAndID)
    }


    func setUpNewDialogs(dialog1TextAndID: (text: String,id: Int), dialog2TextAndID: (text: String,id: Int)) {
        let buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: buttonSize.menuButton.toCGSize)
        let longerText = dialog1TextAndID.text.count > dialog2TextAndID.text.count ? dialog1TextAndID.text : dialog2TextAndID.text
        let labelBlueprint = SKLabelNode(text: longerText)
        labelBlueprint.position = CGPoint(x: 0, y: -5)
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)
        
        dialogOption1 = (buttonBlueprint.copy() as? SKSpriteNode)!
        dialogOption1.name = String(dialog1TextAndID.id)
        dialogOption1.position = CGPoint(x: -UIScreen.main.bounds.width / 4, y: -UIScreen.main.bounds.height / 4)
        dialogOption1.zPosition = 10
        labelBlueprint.text = dialog1TextAndID.text
        dialogOption1.addChild(labelBlueprint.copy() as! SKLabelNode)
        dialogOption1.isHidden = true

        dialogOption2 = (buttonBlueprint.copy() as? SKSpriteNode)!
        dialogOption2.name = String(dialog2TextAndID.id)
        dialogOption2.position = CGPoint(x: UIScreen.main.bounds.width / 4, y: -UIScreen.main.bounds.height / 4)
        dialogOption2.zPosition = 10
        labelBlueprint.text = dialog2TextAndID.text
        dialogOption2.addChild(labelBlueprint.copy() as! SKLabelNode)
        dialogOption2.isHidden = true
        finished = false
        resolution = nil
        active = false
    }

    func showDialog(parentNode: SKNode) {
        active = true
        dialogBackground.isHidden = false
        dialogOption1.isHidden = false
        dialogOption2.isHidden = false
        parentNode.addChild(dialogBackground)
        parentNode.addChild(dialogOption1)
        parentNode.addChild(dialogOption2)
    }

    private func removeDialog() {
        dialogBackground.removeFromParent()
        dialogOption1.removeFromParent()
        dialogOption2.removeFromParent()
        active = false
    }


    func dialogResolution(touches: Set<UITouch>, touchedIn: SKNode) -> Int? {
        if let t = touches.first?.location(in: touchedIn) {
            if !(dialogOption1.isHidden), dialogOption1.frame.contains(t) {
                resolution = Int(dialogOption1.name!)
                removeDialog()
                finished = true
                return resolution
            } else if !(dialogOption2.isHidden), dialogOption2.frame.contains(t) {
                resolution = Int(dialogOption2.name!)
                removeDialog()
                finished = true
                return resolution
            }
        }
        return nil
    }

}

