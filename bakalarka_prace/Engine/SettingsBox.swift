//
//  SetingsBox.swift
//
//  Copyright (c) 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class SettingsBox {

    private(set) var back: SKSpriteNode
    private(set) var active: Bool
    let helpBlackBackground: SKSpriteNode
    private var joystickButton: SKSpriteNode?
    private var textSpeedButton: SKSpriteNode?
    private let joystick: Joystick
    
    private let deviceBounds: CGRect

    init(joystick jStick: Joystick, deviceBounds bounds: CGRect=UIScreen.main.bounds) {
        deviceBounds = bounds
        back = SKSpriteNode(color: .black, size: .zero);
        helpBlackBackground = SKSpriteNode(color: UIColor.darkGray, size: deviceBounds.size)
        helpBlackBackground.zPosition = 19
        helpBlackBackground.isHidden = true
        active = false
        joystick = jStick
        setUpSettingsBox()
    }

    private func setUpSettingsBox() {
        var buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: buttonSize.pauseButton.toCGSize(withBounds: deviceBounds))
        var labelBlueprint = SKLabelNode(text: "Save")
        labelBlueprint.position = CGPoint(x: 0, y: -(buttonSize.pauseButton.toCGSize.height / 9))
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        back = (buttonBlueprint.copy() as? SKSpriteNode)!
        back.position = CGPoint(x: (deviceBounds.width / 2) - (buttonBlueprint.size.width) / 2, y: (deviceBounds.height / 2) - (buttonBlueprint.size.height) / 2)
        back.zPosition = 20
        labelBlueprint.fontSize = buttonBlueprint.size.height / 8
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)
        back.addChild(labelBlueprint.copy() as! SKLabelNode)

        buttonBlueprint = SKSpriteNode(texture: SKTexture(imageNamed: "mainMenu"), size: buttonSize.menuButton.toCGSize(withBounds: deviceBounds))
        labelBlueprint = SKLabelNode(text: "Reading speed: Normal")

        labelBlueprint.position = CGPoint(x: 0, y: 0)
        labelBlueprint.color = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        labelBlueprint.fontName = "HelveticaNeue-MediumItalic"
        labelBlueprint.fontSize = buttonBlueprint.size.height / 4
        adjustLabelFontSizeToFitRect(labelNode: labelBlueprint, size: buttonBlueprint.size)

        joystickButton = buttonBlueprint.copy() as? SKSpriteNode
        joystickButton?.position = CGPoint(x: 0, y: deviceBounds.height / 6)
        joystickButton?.zPosition = 20
        if joystick.isDynamic{
            labelBlueprint.text = "Dynamic Joystick"
        }else{
            labelBlueprint.text = "Static Joystick"
        }
        joystickButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        joystickButton?.isHidden = true

        textSpeedButton = buttonBlueprint.copy() as? SKSpriteNode
        textSpeedButton?.position = CGPoint(x: 0, y: -(deviceBounds.height / 6))
        if let speed = readingSpeed(rawValue: READING_SPEED){
            labelBlueprint.text = "Reading speed: " + speed.text()
        }else{
            setNewReadingSpeed(speed: .normal)
            labelBlueprint.text = "Reading speed: Normal"
        }
        textSpeedButton?.addChild(labelBlueprint.copy() as! SKLabelNode)
        textSpeedButton?.zPosition = 20
        textSpeedButton?.isHidden = true

        back.isHidden = true
        active = false
    }

    func showSettings(parentNode: SKNode) {
        active = true
        helpBlackBackground.isHidden = false
        joystickButton?.isHidden = false
        textSpeedButton?.isHidden = false
        back.isHidden = false
        parentNode.addChild(helpBlackBackground)
        parentNode.addChild(joystickButton!)
        parentNode.addChild(textSpeedButton!)
        parentNode.addChild(back)
    }

    private func removeSettings() {
        joystickButton?.removeFromParent()
        textSpeedButton?.removeFromParent()
        helpBlackBackground.removeFromParent()
        back.removeFromParent()
        active = false
    }

    private func saveSettings() {
        print("bef",UserDefaults.standard.integer(forKey: "textSpeed"))
        UserDefaults.standard.set(joystick.isDynamic, forKey: "joystickSettings")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(Int(READING_SPEED), forKey: "textSpeed")
        print("after",UserDefaults.standard.integer(forKey: "textSpeed"))
    }

    func didTouched(touches: Set<UITouch>, touchedIn: SKNode){
        if let t = touches.first?.location(in: touchedIn) {
            if back.frame.contains(t) {
                removeSettings()
                active = false
                saveSettings()
            }else if (joystickButton?.frame.contains(t))!{
                joystick.isDynamic = !joystick.isDynamic
                if joystick.isDynamic{
                    (joystickButton?.children.first as? SKLabelNode)?.text = "Dynamic joystick"
                }else{
                    (joystickButton?.children.first as? SKLabelNode)?.text = "Static joystick"
                }
            }else if (textSpeedButton?.frame.contains(t))!{
                switch READING_SPEED{
                case readingSpeed.slow.rawValue:
                    setNewReadingSpeed(speed: .normal)
                    (textSpeedButton?.children.first as? SKLabelNode)?.text = "Reading speed: Normal"
                case readingSpeed.normal.rawValue:
                    setNewReadingSpeed(speed: .fast)
                    (textSpeedButton?.children.first as? SKLabelNode)?.text = "Reading speed: Fast"
                case readingSpeed.fast.rawValue:
                    setNewReadingSpeed(speed: .slow)
                    (textSpeedButton?.children.first as? SKLabelNode)?.text = "Reading speed: Slow"
                default:
                    break
                }
            }
        }
    }

}

