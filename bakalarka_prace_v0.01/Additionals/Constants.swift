//
//  Constants.swift
//  bakalarka_prace_v0.01
//
//  Created by Janko on 11/10/2018.
//  Copyright © 2018 Jan Czerny. All rights reserved.
//

import Foundation

enum bitmasks : UInt32 , CaseIterable {
    case player = 0b1
    case activeBackground = 0b10
    case frame = 0b11
    case camera = 0b100
    case searcher = 0b101
    
    init?(id: Int){
        switch id {
        case 1: self = .player
        case 2: self = .activeBackground
        case 3: self = .frame
        case 4: self = .searcher
        default: return nil
        }	
    }
}

