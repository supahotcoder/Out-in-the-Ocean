//
// Created by Janko on 26.12.2022.
// Copyright (c) 2022 Jan Czerny. All rights reserved.
//

import Foundation
import GameplayKit

class TriggerComponent: GKComponent {

    private(set) var isTriggered: Bool = false
    private var isFinished: Bool = false

    func didTrigger(){
        if !isFinished{
            isTriggered = true
        }
    }

    func canceled() {
        if !isFinished{
            isTriggered = false
        }
    }

    func finished(){
        isTriggered = true
        isFinished = true
    }

    func restartTrigger(){
        isTriggered = false
        isFinished = false
    }

}