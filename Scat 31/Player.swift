//
//  Player.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

enum Player {
    case computer
    case player
    
    var description: String {
        switch self {
        case .computer: return "Computer"
        case .player: return "Player"
        }
    }
    
    var debugDescription: String {
        return description
    }
}

