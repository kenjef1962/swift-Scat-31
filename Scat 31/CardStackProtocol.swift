//
//  CardStackProtocol
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

protocol CardStackProtocol {
    var cards: [Card] { get set }
    var count: Int { get }
    
    var topCard: Card? { get }

    mutating func addToStack(card: Card)
    mutating func drawFromStack() -> Card?
    mutating func emptyStack()
    
    func getCardByAbbreviation(at: Int) -> String?
    func getCardBySymbol(at: Int) -> String?

    func getTopCardByAbbreviation() -> String?
    func getTopCardBySymbol() -> String?
}

extension CardStackProtocol {
    var count: Int {
        return cards.count;
    }
    
    var topCard: Card? {
        return cards.first
    }
    
    mutating func addToStack(card: Card) {
        cards.insert(card, at: 0)
    }
    
    mutating func drawFromStack() -> Card? {
        guard let card = cards.first else { return nil }
        cards.removeFirst()
        
        return card
    }
    
    mutating func emptyStack() {
        cards.removeAll()
    }
    
    func getCardByAbbreviation(at index: Int) -> String? {
        guard index < cards.count else { return nil }
        
        return cards[index].abbreviation
    }
    
    func getCardBySymbol(at index: Int) -> String? {
        guard index < cards.count else { return nil }
        
        return cards[index].symbol
    }
    
    func getTopCardByAbbreviation() -> String? {
        return getCardByAbbreviation(at: 0)
    }

    func getTopCardBySymbol() -> String? {
        return getCardBySymbol(at: 0)
    }
}
