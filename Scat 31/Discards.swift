//
//  Discards.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/7/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

struct Discards: CardStackProtocol {
    var cards = [Card]()
    
    func getAllCardsByAbbreviation() -> String {
        return self.cards.map { return $0.abbreviation }.joined(separator: "\n")
    }
    
    func getAllCardsBySymbol() -> String {
        return self.cards.map { return $0.symbol }.joined(separator: "\n")
    }
}
