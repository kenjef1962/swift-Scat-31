//
//  Deck.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

class CardStack {
    internal var cards = [Card]()
    
    var cardCount: Int { get { return cards.count } }
    var topCard: Card? { get { return (0 < cards.count) ? cards[0] : nil } }

    init () {
        clearAll()
    }
    
    func clearAll() {
        cards.removeAll(keepingCapacity: true)
    }
    
    func drawCard() -> Card? {
        if (0 == cards.count) { return nil }
        
        let card = cards[0]
        cards.remove(at: 0)
        
        return card
    }
    
    func showCards() -> String {
        var displayString = ""
        
        for card in cards {
            if displayString.isEmpty {
                displayString = "\(card.symbol)"
            }
            else  {
                displayString = "\(displayString)\n\(card.symbol)"
            }
        }
        
        return displayString
    }
}
