//
//  Constants.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

// pohyb kamery je nastaven na 0.3 sekundy at je vic prirozeny
let CAMERA_MOVEMENT_TIME: Double = 0.3
// promena se pouziva pro nastaveni doby po kterou text zustava na obrazovce (nekteri hraci ctou pomaleji/rychleji)
private(set) var READING_SPEED: Double = UserDefaults.standard.integer(forKey: "textSpeed") != 0 ? Double(UserDefaults.standard.integer(forKey: "textSpeed")) : readingSpeed.normal.rawValue


enum readingSpeed: Double{

    case slow = 10
    case normal = 14
    case fast = 19

    func getForDurationModifier() -> TimeInterval{
        switch self{
        case .slow:
            return 1.286
        case .normal:
            return 1
        case .fast:
            return 0.736
        }
    }

    public func text() -> String {
        switch self{

        case .slow:
            return "Slow"
        case .normal:
            return "Normal"
        case .fast:
            return "Fast"
        }
    }
}

func setNewReadingSpeed(speed: readingSpeed){
//    nastavi novou rychlost pro modifikaci doby po kterou je text na obrazovce
    READING_SPEED = speed.rawValue
}

enum bitmasks : UInt32 , CaseIterable {
//    bitmasky pouzivaji se pro identifikaci fyzickeho tela, ktere pak muze z dalsim napriklad kolidovat
   // case boundaries = 0b0
    case player = 0b1
    case activeBackground = 0b10
    case frame = 0b11
    case camera = 0b100
    case searcher = 0b101
    case wander = 0b110
    case collectible = 0b111
    case storyTeller = 0b1000
}

enum textPosition {
//    pozice pro zobrazovani textu
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
    case onEntity
    
    var toCGPoint: CGPoint{
        switch self {
        case .leftTop:
            return CGPoint(x: -60, y: 60)
        case .leftBottom:
            return CGPoint(x: -60, y: -60)
        case .rightTop:
            return CGPoint(x: 60, y: 60)
        case .rightBottom:
            return CGPoint(x: 60, y: -60)
        case .onEntity:
            return CGPoint(x: 50, y: -40)
        }
    }
}

enum buttonSize  {
//    nastaveni dynamicke velikosti tlacitek, diky nejz muzeme jednoduse portovat na ruzne velikosti obrazovek
    case closeButton
    case pauseButton
    case menuButton
    
    var toCGSize: CGSize{
        var aspectRatio: CGFloat = 1/1.7
        switch self {
        case .closeButton:
            let width = UIScreen.main.bounds.width / 10
            return CGSize(width: width, height: width * aspectRatio)
        case .pauseButton:
            let width = UIScreen.main.bounds.width / 8
            return CGSize(width: width, height: width * aspectRatio)
        case .menuButton:
            aspectRatio = 1/2
            let width = UIScreen.main.bounds.width / 4
            return CGSize(width: width, height: width * aspectRatio)
        }
    }
    
    func toCGSize(withBounds: CGRect) -> CGSize {
        var aspectRatio: CGFloat = 1/1.7
        switch self {
        case .closeButton:
            let width = withBounds.width / 10
            return CGSize(width: width, height: width * aspectRatio)
        case .pauseButton:
            let width = withBounds.width / 8
            return CGSize(width: width, height: width * aspectRatio)
        case .menuButton:
            aspectRatio = 1/2
            let width = withBounds.width / 4
            return CGSize(width: width, height: width * aspectRatio)
        }
    }
}

func isRunningInSimulator() -> Bool {
//    zjisteni zda bezi hra v simulatoru (nektere simulatory (15.2 iOS) maji obcas problemy)
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, size:CGSize) {
//    prizpusobi velikost fontu pro dany labelNode
    let scalingFactor = min(size.width / labelNode.frame.width, size.height / labelNode.frame.height) * 0.75
    labelNode.fontSize *= scalingFactor
}

func prepareTextActions(displayIn: TimeInterval, fadeIn: TimeInterval = 0, fadeOut: TimeInterval, label: SKLabelNode, around: SKNode, alignment: textPosition=textPosition.leftBottom, forDuration: TimeInterval?=nil) -> [SKAction]{
//    pripravi akce pro zobrazeni textu na obrazovku
    var showForDur = TimeInterval((label.text?.count)!) / READING_SPEED
    if let duration = forDuration{
        showForDur = duration * (readingSpeed(rawValue: READING_SPEED)?.getForDurationModifier()  ?? 1)
    }
    return [SKAction.wait(forDuration: displayIn),SKAction.run{label.trackNode(node: around,labelAlligment: alignment.toCGPoint)},SKAction.fadeIn(withDuration: fadeIn),
           SKAction.wait(forDuration: showForDur),SKAction.fadeOut(withDuration: fadeOut), SKAction.removeFromParent()]
}

func deviceAdjustments(_ device: UIUserInterfaceIdiom, _ screen: CGRect) -> CGFloat {
//    prizpusobeni pro ruzne Apple zarizeni
    var size: CGFloat = 1
    switch device {
    case .pad:
        size = 2
    case .phone:
        if (screen.width + screen.height) < 6000{
            size = 2.3
        }
    default:
        break
    }
    return size
}
