//
//  SuitTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/28/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class SuitTests: XCTestCase {
    func testSuit_Clubs() {
        let suit = Suit.clubs
        
        XCTAssertEqual("♣️", suit.symbol)
        XCTAssertEqual("Clubs", suit.stringValue)
    }
    
    func testSuit_Diamonds() {
        let suit = Suit.diamonds
        
        XCTAssertEqual("♦️", suit.symbol)
        XCTAssertEqual("Diamonds", suit.stringValue)
    }
    
    func testSuit_Hearts() {
        let suit = Suit.hearts
        
        XCTAssertEqual("♥️", suit.symbol)
        XCTAssertEqual("Hearts", suit.stringValue)
    }
    
    func testSuit_Spades() {
        let suit = Suit.spades
        
        XCTAssertEqual("♠️", suit.symbol)
        XCTAssertEqual("Spades", suit.stringValue)
    }
    
    func testSuit_RawValues() {
        for value in 0..<4 {
            let suit = Suit(rawValue: value)
            
            XCTAssertNotNil(suit)
            XCTAssertEqual(value, suit?.rawValue)
        }
        
        let suit = Rank(rawValue: 99)
        XCTAssertNil(suit)
    }
}
