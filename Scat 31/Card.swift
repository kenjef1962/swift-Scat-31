//
//  Card.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit
import Foundation

struct Card {
    var suit: Suit
    var rank: Rank
    
    var abbreviation: String {
        get {
            return "\(rank.abbreviation)-\(suit.abbreviation)"
        }
    }
    
    var symbol: String {
        get {
            return "\(rank.symbol)-\(suit.symbol)"
        }
    }
    
    var stringValue: String {
        return "\(rank.stringValue)-\(suit.stringValue)"
    }
    
    var pipValue: Int {
        get {
            switch rank {
            case .ace: return 11
            case .jack: return 10
            case .queen: return 10
            case .king: return 10
            default: return rank.rawValue
            }
        }
    }
    
    var backImage: UIImage? {
        get {
            return UIImage(named: "CardBack")
        }
    }
    
    var faceImage: UIImage? {
        get {
            return UIImage(named: abbreviation)
        }
    }
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
}
