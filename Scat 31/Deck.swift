//
//  Deck.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

class Deck: CardStack {
    func generate() {
        super.clearAll()
        
        for index in 0..<52 {
            guard let suit = Suit(rawValue: index / 13) else { fatalError() }
            guard let rank = Rank(rawValue: (index % 13) + 1) else { fatalError() }
            
            let card = Card(suit: suit, rank: rank)
            cards.append(card)
        }
    }
    
    func shuffle() {
        if (cards.count == 0) {
            generate()
        }
        
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
