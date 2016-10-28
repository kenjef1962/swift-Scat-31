//
//  Suit.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

enum Suit: Int {
    case clubs = 0
    case diamonds
    case hearts
    case spades
    
    var symbol: String {
        switch self {
        case .clubs: return "♣️"
        case .diamonds: return "♦️"
        case .hearts: return "♥️"
        case .spades: return "♠️"
        }
    }
    
    var abbreviation: String {
        switch self {
        case .clubs: return "C"
        case .diamonds: return "D"
        case .hearts: return "H"
        case .spades: return "S"
        }
    }
    
    var stringValue: String {
        switch self {
        case .clubs: return "Clubs"
        case .diamonds: return "Diamonds"
        case .hearts: return "Hearts"
        case .spades: return "Spades"
        }
    }
}

