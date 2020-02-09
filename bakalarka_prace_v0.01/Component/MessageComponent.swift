//
//  MessageComponent.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 18/12/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class MessageComponent: GKComponent {

    private var msg = SKLabelNode(text: "")
    
    private let entityNode: SKSpriteNode
    
    private let entityManager: EntityManager
    
    private let msgs: [String]
    private let warning: [String]
    
    private var current = 0
    private let loop: Int
    
    //FIXME : CHANGE
    init(node: SKSpriteNode, entityManager: EntityManager,messages: [String], loopOn: Int, warningMsgs: [String]) {
        self.entityManager = entityManager
        entityNode = node
        msgs = messages
        loop = loopOn >= msgs.count ? msgs.count - 1 : loopOn
        warning = warningMsgs
        super.init()

        msg.fontSize = 20
        msg.zPosition = 5
        msg.alpha = 0
        msg.fontName = "Futura-CondensedExtraBold"
        msg.numberOfLines = 3
        current = Int.random(in: 0..<messages.count / 2)
    }
    
    func showMsg() {
        if msg.parent == nil{
            if current < msgs.count{
                prepareMsg(with: msgs[current],fadeIn: 0.75,fadeOut: 1.5)
                current += 1
            }
            else if loop > 0{
                current = loop
                prepareMsg(with: msgs[current],fadeIn: 0.75,fadeOut: 1.5)
            }
            else{
                current = 0
            }
        }
    }
    
    func showWarningMsg() {
        if msg.parent == nil && warning.count != 0{
            let i = Int.random(in: 0..<warning.count)
            prepareMsg(with: warning[i],fadeIn: 0, fadeOut: 1)
        }
    }
    
    private func prepareMsg(with text: String,fadeIn: TimeInterval, fadeOut: TimeInterval) {
        msg.text = text
        entityManager.addMsg(msgLabel: msg)
        displayText(displayIn: fadeIn, fadeOut: fadeOut, label: msg, around: entityNode, alligment: position.rightBottom)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
