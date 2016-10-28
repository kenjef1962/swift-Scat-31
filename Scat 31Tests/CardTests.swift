//
//  CardTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/28/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class CardTests: XCTestCase {
    func testCard() {
        for suitValue in 0..<4 {
            guard let suit = Suit(rawValue: suitValue) else { fatalError() }
            
            for rankValue in 1...13 {
                guard let rank = Rank(rawValue: rankValue) else { fatalError() }
                
                let card = Card(suit: suit, rank: rank)
                
                XCTAssertEqual("\(rank.abbreviation)-\(suit.abbreviation)", card.abbreviation)
                XCTAssertEqual("\(rank.symbol)-\(suit.symbol)", card.symbol)
                XCTAssertEqual("\(rank.stringValue)-\(suit.stringValue)", card.stringValue)
                
                switch rank {
                case .ace: XCTAssertEqual(11, card.value)
                case .jack: XCTAssertEqual(10, card.value)
                case .queen: XCTAssertEqual(10, card.value)
                case .king: XCTAssertEqual(10, card.value)
                default: XCTAssertEqual(rank.rawValue, card.value)
                }
                
                guard card.back != nil else { XCTAssert(false); continue }
                guard card.face != nil else { XCTAssert(false); continue }
            }
        }
    }
}
