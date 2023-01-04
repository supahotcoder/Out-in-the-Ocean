//
//  MessageComponent.swift
//
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class MessageComponent: GKComponent {

    private var msgLabel: SKLabelNode? = SKLabelNode(text: "")
    private var lastMsgDate: Date

    private let entityNode: SKSpriteNode
    
    private let entityManager: EntityManager
    
    private let messages: [String]
    private let warning: [String]
    
    private var currentMsg = 0
    private var loopMsgOn: Int = -1
    
    init(node: SKSpriteNode, entityManager: EntityManager,messages msgs: [String], loopOn: Int? = nil, warningMsgs: [String]) {
        self.entityManager = entityManager
        entityNode = node
        messages = msgs
        if let loop = loopOn{
            loopMsgOn = loop >= messages.count ? messages.count - 1 : loop
        }
        warning = warningMsgs
        lastMsgDate = Date.distantPast
        super.init()

        if messages.count == 1{
            currentMsg = 0
        }else{
            currentMsg = Int.random(in: 0..<Int(ceil(Double(messages.count / 2))))
        }
    }
    
    func showMsg() {
        if -lastMsgDate.timeIntervalSinceNow > 5{
            if msgLabel?.parent == nil{
                if currentMsg < messages.count{
                    displayMessage(with: messages[currentMsg])
                    currentMsg += 1
                }
                else if loopMsgOn > 0{
                    currentMsg = loopMsgOn
                    displayMessage(with: messages[currentMsg])
                }
                else if loopMsgOn != -1{
                    currentMsg = 0
                }
            }
        }
    }
    
    func showWarningMsg() {
        if msgLabel?.parent == nil && warning.count != 0{
            let i = Int.random(in: 0..<warning.count)
            displayMessage(with: warning[i])
        }
    }
    
    private func displayMessage(with text: String) {
        lastMsgDate = Date()
        msgLabel = entityManager.giveFeedback(text: text, around: entityNode)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
