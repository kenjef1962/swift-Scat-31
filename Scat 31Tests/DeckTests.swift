//
//  DeckTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/30/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class DeckTests: XCTestCase {
    func testDeck_Init() {
        let deck = Deck()
        
        XCTAssertEqual(52, deck.count)
        XCTAssertTrue(isDeckOrdered(deck: deck))
    }
    
    func testDeck_Reset() {
        var deck = Deck()
        deck.reset()
        
        XCTAssertEqual(52, deck.count)
        XCTAssertTrue(isDeckOrdered(deck: deck))
    }

    func testDeck_Shuffle() {
        var deck = Deck()
        deck.shuffle()
        
        XCTAssertEqual(52, deck.count)
        XCTAssertTrue(!isDeckOrdered(deck: deck))
    }
    
    func isDeckOrdered(deck: Deck) -> Bool {
        let aceClubs = Card(suit: Suit.clubs, rank: Rank.ace)
        let aceDiamonds = Card(suit: Suit.diamonds, rank: Rank.ace)
        let aceHearts = Card(suit: Suit.hearts, rank: Rank.ace)
        let aceSpades = Card(suit: Suit.spades, rank: Rank.ace)
        
        let sevenClubs = Card(suit: Suit.clubs, rank: Rank.seven)
        let sevenDiamonds = Card(suit: Suit.diamonds, rank: Rank.seven)
        let sevenHearts = Card(suit: Suit.hearts, rank: Rank.seven)
        let sevenSpades = Card(suit: Suit.spades, rank: Rank.seven)
        
        var ordered = true
        ordered = ordered && aceClubs.abbreviation == deck.getCardByAbbreviation(at: 51)
        ordered = ordered && aceDiamonds.abbreviation == deck.getCardByAbbreviation(at: 38)
        ordered = ordered && aceHearts.abbreviation == deck.getCardByAbbreviation(at: 25)
        ordered = ordered && aceSpades.abbreviation == deck.getCardByAbbreviation(at: 12)
        
        ordered = ordered && sevenClubs.abbreviation == deck.getCardByAbbreviation(at: 45)
        ordered = ordered && sevenDiamonds.abbreviation == deck.getCardByAbbreviation(at: 32)
        ordered = ordered && sevenHearts.abbreviation == deck.getCardByAbbreviation(at: 19)
        ordered = ordered && sevenSpades.abbreviation == deck.getCardByAbbreviation(at: 6)
        
        return ordered
    }
}
