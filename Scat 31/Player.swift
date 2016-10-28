//
//  Player.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

enum Player: Int {
    case computer = 0
    case player
    
    var abbreviation: String {
        switch self {
        case .computer: return "C"
        case .player: return "P"
        }
    }
    
    var symbol: String {
        switch self {
        case .computer: return "🖥"
        case .player: return "👤"
        }
    }
    
    var stringValue: String {
        switch self {
        case .computer: return "Computer"
        case .player: return "Player"
        }
    }
}

