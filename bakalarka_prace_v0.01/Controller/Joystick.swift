//
//  Joystick.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import SpriteKit
import GameplayKit

class Joystick {
    
    private(set) var node : SKSpriteNode?
    private(set) var insideFrame : Bool
    private let maxVelocity : CGFloat = 100
    private let speed: CGFloat = 4
    private let screen: CGRect

    var isDynamic: Bool{
        didSet {
            if !isDynamic{
                placeStaticJoystick()
            }
            enableJoystick()
        }
    }
    var isHidden: Bool = false
    var didEnable: Bool = false
    
    var touch : CGPoint = CGPoint(x: 0, y: 0){
        // až při nastavování místa doteku v joysticku se počítá přesný pohyb páčky
        // hlavní důvod tohohle je přehlednost v GameScene
        willSet (position){
            if  thumbstick.radius < position.length(){
                let startPosition = CGPoint(x: (position.x / touchRadius) , y: (position.y / touchRadius))
                let thumb = CGPoint(x: startPosition.x * thumbstick.radius, y: startPosition.y * thumbstick.radius)
                thumbstick.moveTo(position: thumb)
            }
            else{
                thumbstick.moveTo(position: position)
            }
        }
    }
    
    let touchRadius : CGFloat
    var turnAngle : CGFloat = 0
    
    let thumbstick : Thumbstick
    
    init(screen screenRect: CGRect,adjustment: CGFloat) {
        screen = screenRect
        touchRadius = (screen.width + screen.height) * 0.05 * adjustment
        let texture = SKTexture(imageNamed: "joystick")
        node = SKSpriteNode(texture: texture, color: .white, size: CGSize(width: touchRadius, height: touchRadius))

        //inicializace páčky v joysticku
        thumbstick = Thumbstick(screen: screen, adjustment: adjustment)
        isDynamic = true
        if isDynamic{
            node?.isHidden = true
            insideFrame = false
        }else{
            node?.isHidden = false
            insideFrame = false
        }
        placeStaticJoystick()
    }

    private func placeStaticJoystick() {
        node?.position = CGPoint(x: Double(screen.width) * -0.3, y: Double(screen.height) *  -0.3)
        node?.isHidden = false
        insideFrame = false
    }

    //kontrola kliknutí do joysticku
    func didTouchJoystick(location: CGPoint){
        if isDynamic, !(node?.isPaused ?? false){
            node?.position = location
            insideFrame = true
            node?.isHidden = false
        }else{
            insideFrame = (node?.frame.contains(location))!
        }
    }

    func enableJoystick() {
        if isDynamic{
            didEnable = true
            node?.isHidden = true
        }
    }
    
    //konec pohybu
    func stopMovement(){
        insideFrame = false
        touch = CGPoint(x: 0, y: 0)
//      pokud schovame joystick tak se nastavi true (nelze se pak hybat kdyz je joystick schovany)
        if let hiddenUnwrp = node?.isHidden{
            if !didEnable{
                isHidden = hiddenUnwrp
//          joystick jsme restartovali pomoci resme tlacitka (diky kodu nize se nezmrazi pohyb)
            }else{
                isHidden = false
                didEnable = false
            }
        }
        if isDynamic{
            node?.isHidden = true
        }
    }
    
    //zpomalení
    func stealthMode(playerNode: SKSpriteNode){
        var playerVel = playerNode.physicsBody?.velocity
        playerVel?.dx *= 0.4
        playerVel?.dy *= 0.4
        playerNode.physicsBody?.velocity = playerVel!
        if isDynamic{
            insideFrame = true
        }else{
            insideFrame = false
        }
    }

    
    // regulátor maximální rychlosti
    func maxVelocityCheck(node : SKSpriteNode){
        var velocity = (node.physicsBody?.velocity)!
        let deltaZ = sqrt(pow(velocity.dx, 2) + pow(velocity.dy, 2))
        if deltaZ > maxVelocity{
            let xPart = velocity.dx / deltaZ
            let yPart = velocity.dy / deltaZ
            let newDeltaX = xPart * maxVelocity
            let newDeltaY = yPart * maxVelocity
            node.physicsBody?.velocity = CGVector(dx: newDeltaX, dy: newDeltaY)
        }
    }
    
    //pohyb s hráčem
    var lastMovement = CGVector(dx: 0, dy: 0)
    func movement(moveWith node: SKSpriteNode) {
        if insideFrame && !isHidden{
            let movement = CGVector(dx: (thumbstick.node.position.x * speed), dy:  (thumbstick.node.position.y * speed))
            if movement != CGVector.zero{
                let rotation = SKAction.rotate(toAngle: (turnAngle + CGFloat(90 * (Double.pi/50)) + 0.7), duration: 0.1, shortestUnitArc: true)
                node.run(rotation)
                //maxspeed check
                node.physicsBody?.velocity = movement
                maxVelocityCheck(node: node)
            }
        }
    }
    
}
