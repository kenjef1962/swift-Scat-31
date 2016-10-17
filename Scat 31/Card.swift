//
//  Card.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

enum Suit: Int {
    case clubs = 0
    case diamonds
    case spades
    case hearts
    
    var symbol: String {
        switch self {
        case .clubs: return "♣️"
        case .diamonds: return "♦️"
        case .hearts: return "♥️"
        case .spades: return "♠️"
        }
    }
    
    var description: String {
        switch self {
        case .clubs: return "Clubs"
        case .diamonds: return "Diamonds"
        case .hearts: return "Hearts"
        case .spades: return "Spades"
        }
    }
    
    var debugDescription: String {
        return description
    }
}

enum Face: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    var symbol: String {
        switch self {
        case .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default: return "\(rawValue)"
        }
    }
    
    var description: String {
        switch self {
        case .ace: return "Ace"
        case .jack: return "Jack"
        case .queen: return "Queen"
        case .king: return "King"
        default: return "\(rawValue)"
        }
    }
    
    var debugDescription: String {
        return description
    }
}

class Card {
    var suit: Suit
    var face: Face
    var value: Int {
        get {
            switch face {
            case .ace: return 11
            case .jack: return 10
            case .queen: return 10
            case .king: return 10
            default: return face.rawValue
            }
            
        }
    }
    
    init(suit: Suit, face: Face) {
        self.suit = suit
        self.face = face
    }
    
    var symbol: String {
        return "\(face.symbol)\(suit.symbol)"
    }
    
    var description: String {
        return "\(face.description)-\(suit.description)"
    }
    
    var debugDescription: String {
        return description
    }
}
