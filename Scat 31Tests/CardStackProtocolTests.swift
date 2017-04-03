//
//  CardStackProtocolTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/30/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class CardStackProtocolTests: XCTestCase {
    func testCardStackProtocol() {
        struct Stack: CardStackProtocol {
            var cards = [Card]()
        }
    
        let aceSpades = Card(suit: .spades, rank: .ace)
        let aceHearts = Card(suit: .hearts, rank: .ace)
        let aceDiamonds = Card(suit: .diamonds, rank: .ace)
        let aceClubs = Card(suit: .clubs, rank: .ace)
        var stack = Stack()

        // Empty Stack
        XCTAssertNotNil(stack.cards)
        XCTAssertEqual(0, stack.count)
        XCTAssertNil(stack.topCard)

        // Draw from Stack (empty)
        var card = stack.drawFromStack()
        
        XCTAssertNil(card)
        
        // Add to Stack / Top Card
        stack.addToStack(card: aceSpades)
        
        XCTAssertEqual(1, stack.count)
        XCTAssertEqual(aceSpades.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceSpades.abbreviation, stack.getTopCardByAbbreviation())
        XCTAssertEqual(aceSpades.symbol, stack.getTopCardBySymbol())
        
        // Add to Stack / Top Card
        stack.addToStack(card: aceHearts)
        
        XCTAssertEqual(2, stack.count)
        XCTAssertEqual(aceHearts.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceHearts.abbreviation, stack.getTopCardByAbbreviation())
        XCTAssertEqual(aceHearts.symbol, stack.getTopCardBySymbol())
        
        // Add to Stack / Top Card
        stack.addToStack(card: aceDiamonds)
        
        XCTAssertEqual(3, stack.count)
        XCTAssertEqual(aceDiamonds.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceDiamonds.abbreviation, stack.getTopCardByAbbreviation())
        XCTAssertEqual(aceDiamonds.symbol, stack.getTopCardBySymbol())
        
        // Add to Stack / Top Card
        stack.addToStack(card: aceClubs)
        
        XCTAssertEqual(4, stack.count)
        XCTAssertEqual(aceClubs.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceClubs.abbreviation, stack.getTopCardByAbbreviation())
        XCTAssertEqual(aceClubs.symbol, stack.getTopCardBySymbol())

        // Positions in Stack
        XCTAssertEqual(nil, stack.getCardByAbbreviation(at: 99))
        XCTAssertEqual(aceSpades.abbreviation, stack.getCardByAbbreviation(at: 3))
        XCTAssertEqual(aceHearts.abbreviation, stack.getCardByAbbreviation(at: 2))
        XCTAssertEqual(aceDiamonds.abbreviation, stack.getCardByAbbreviation(at: 1))
        XCTAssertEqual(aceClubs.abbreviation, stack.getCardByAbbreviation(at: 0))
        
        // Setting Cards
        stack.cards = [aceSpades, aceClubs, aceDiamonds, aceHearts]
        
        XCTAssertEqual(aceSpades.abbreviation, stack.getCardByAbbreviation(at: 0))
        XCTAssertEqual(aceClubs.abbreviation, stack.getCardByAbbreviation(at: 1))
        XCTAssertEqual(aceDiamonds.abbreviation, stack.getCardByAbbreviation(at: 2))
        XCTAssertEqual(aceHearts.abbreviation, stack.getCardByAbbreviation(at: 3))
        
        // Draw from Stack / Top Card
        card = stack.drawFromStack()
        
        XCTAssertEqual(3, stack.count)
        XCTAssertEqual(aceClubs.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceSpades.symbol, card?.symbol)
        
        card = stack.drawFromStack()
        
        // Draw from Stack / Top Card
        XCTAssertEqual(2, stack.count)
        XCTAssertEqual(aceDiamonds.symbol, stack.topCard?.symbol)
        XCTAssertEqual(aceClubs.symbol, card?.symbol)
        
        // Empty Stack
        stack.emptyStack()
        
        XCTAssertNotNil(stack.cards)
        XCTAssertEqual(0, stack.count)
        XCTAssertNil(stack.topCard)
    }
}
