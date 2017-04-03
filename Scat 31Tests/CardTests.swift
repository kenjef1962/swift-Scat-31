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
            // Force unwrapped okay as Suit testing is done in SuitTests.swift
            let suit = Suit(rawValue: suitValue)!
            
            for rankValue in 1...13 {
                // Force unwrapped okay as Rank testing is done in RankTests.swift
                let rank = Rank(rawValue: rankValue)!
                
                let card = Card(suit: suit, rank: rank)
                
                XCTAssertEqual("\(rank.abbreviation)-\(suit.abbreviation)", card.abbreviation)
                XCTAssertEqual("\(rank.symbol)-\(suit.symbol)", card.symbol)
                XCTAssertEqual("\(rank.stringValue)-\(suit.stringValue)", card.stringValue)
                
                switch rank {
                case .ace: XCTAssertEqual(11, card.pipValue)
                case .jack: XCTAssertEqual(10, card.pipValue)
                case .queen: XCTAssertEqual(10, card.pipValue)
                case .king: XCTAssertEqual(10, card.pipValue)
                default: XCTAssertEqual(rank.rawValue, card.pipValue)
                }
                
                XCTAssertNotNil(card.backImage)
                XCTAssertNotNil(card.faceImage)
            }
        }
    }
}
