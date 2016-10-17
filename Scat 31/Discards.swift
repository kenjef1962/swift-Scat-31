//
//  Discards.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

class Discards: CardStack {
    var lastCard: Card?
    
    override func clearAll() {
        super.clearAll()
        lastCard = nil
    }
    
    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        lastCard = card
    }
}
