//
//  Deck.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

struct Deck: CardStackProtocol {
    var cards = [Card]()
    
    init() {
        reset()
    }
    
    mutating func reset() {
        emptyStack()
        
        for index in 0..<52 {
            if let suit = Suit(rawValue: index / 13), let rank = Rank(rawValue: (index % 13) + 1) {
                let card = Card(suit: suit, rank: rank)
                addToStack(card: card)
            }
        }
    }
    
    mutating func shuffle() {
        reset()
        
        let swaps = max(cards.count, Int(arc4random_uniform(UInt32(cards.count)) * 37))
        
        for _ in 0...swaps {
            let index1 = Int(arc4random_uniform(UInt32(cards.count)))
            let index2 = Int(arc4random_uniform(UInt32(cards.count)))
            
            if (index1 != index2) {
                let card = cards[index2]
                cards[index2] = cards[index1]
                cards[index1] = card
            }
        }
    }
}
