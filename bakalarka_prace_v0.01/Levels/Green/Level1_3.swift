//
//  Level1_3.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 04/04/2019.
//  Copyright © 2019 Jan Czerny. All rights reserved.
//

import Foundation
import SpriteKit

class Level1_3: Level1 {
    
    override func didMove(to view: SKView) {
        //LEVEL FUNCTIONALITY
        self.background = childNode(withName: "pozadi") as? SKSpriteNode
        self.name = "Level1_3"
        super.didMove(to: view)
        
        
        //SEARCHER SETUP
        entityManager.loadSearcher()
        entityManager.loadSearcher()
        // SPINNER SETUP
        let warper = ActiveBackground(imageName: "spin", entityManager: entityManager)
        warperNode = warper.component(ofType: SpriteComponent.self)!.node
        warperNode.run(SKAction.rotate(byAngle: 90, duration: 300))
        self.addChild(warperNode)
        
        //TEXT SETUP
        updateGoalText(with: "Find \n Them \n", around: playerNode!)
        //TEXTMSGS SETUP
        //TODO: - TODO: ADD Text file story strings
        
        //WANDER SETUP
        let msgs = ["Hi" , "...", "Hello stranger" ,"It's getting greener", "Welcome Traveler",
                    "Something,\n is not right in there" ,"Not me", "Did you found\n what you've been looking for?", "Don't bother me"]
        let warning = ["Get out", "Beware","Watch out", "Booo"]
        entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 5, warningMsgs: warning)
        entityManager.loadWander(warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 0, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 2, warningMsgs: warning)
        entityManager.loadWander(messages: msgs, loopOn: 4, warningMsgs: warning)
        //MUSIC SETUP
        backgroundMusic(fileName: "level1_back_sound", extension: "wav")
        
        
        //TESTING - HUE EFFECT for collectible later
        effectNode.shouldRasterize = true
        playerNode?.removeFromParent()
        effectNode.zPosition = 3
        effectNode.addChild(playerNode!)
        effectNode.shouldEnableEffects = true
        self.addChild(effectNode)
        
        //TESTING - spawning collectible and that effect
        #warning("searcher protect collectible")
        // nízké hodnoty zvětšení pro rozeznání
        c1 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c1",protectable: true,entityManager: entityManager)
        c2 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c2",protectable: true,entityManager: entityManager)
        c3 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c3",protectable: true,entityManager: entityManager)
        c4 = Collectible(texture: "donut", size: CGSize(width: 60, height: 60), id: "c4",protectable: true,entityManager: entityManager)
        
        entityManager.add(entity: c1)
        entityManager.add(entity: c2)
        entityManager.add(entity: c3)
        entityManager.add(entity: c4)
    }
}
