//
//  DiscardsTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/30/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class DiscardsTests: XCTestCase {
    func testDiscards_() {
        let discards = Discards()
        
        XCTAssertEqual(0, discards.count)
    }
    
    func testDiscards_GetAllCards() {
        let aceClubs = Card(suit: Suit.clubs, rank: Rank.ace)
        let aceDiamonds = Card(suit: Suit.diamonds, rank: Rank.ace)
        let aceHearts = Card(suit: Suit.hearts, rank: Rank.ace)
        let aceSpades = Card(suit: Suit.spades, rank: Rank.ace)
        
        var discards = Discards()
        
        discards.addToStack(card: aceClubs)
        discards.addToStack(card: aceDiamonds)
        discards.addToStack(card: aceHearts)
        discards.addToStack(card: aceSpades)
        
        XCTAssertEqual(4, discards.count)
        
        let expected1 = "\(aceSpades.abbreviation)\n\(aceHearts.abbreviation)\n\(aceDiamonds.abbreviation)\n\(aceClubs.abbreviation)"
        let actual1 = discards.getAllCardsByAbbreviation()
        
        XCTAssertEqual(expected1, actual1)
        
        let expected2 = "\(aceSpades.symbol)\n\(aceHearts.symbol)\n\(aceDiamonds.symbol)\n\(aceClubs.symbol)"
        let actual2 = discards.getAllCardsBySymbol()
        
        XCTAssertEqual(expected2, actual2)
    }
}
