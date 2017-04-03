//
//  RankTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 10/28/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class RankTests: XCTestCase {
    func testRank_Ace() {
        let rank = Rank.ace
        
        XCTAssertEqual(1, rank.rawValue)
        XCTAssertEqual("A", rank.abbreviation)
        XCTAssertEqual("A", rank.symbol)
        XCTAssertEqual("Ace", rank.stringValue)
    }
    
    func testRank_King() {
        let rank = Rank.king
        
        XCTAssertEqual(13, rank.rawValue)
        XCTAssertEqual("K", rank.abbreviation)
        XCTAssertEqual("K", rank.symbol)
        XCTAssertEqual("King", rank.stringValue)
    }
    
    func testRank_Queen() {
        let rank = Rank.queen
        
        XCTAssertEqual(12, rank.rawValue)
        XCTAssertEqual("Q", rank.abbreviation)
        XCTAssertEqual("Q", rank.symbol)
        XCTAssertEqual("Queen", rank.stringValue)
    }
    
    func testRank_Jack() {
        let rank = Rank.jack
        
        XCTAssertEqual(11, rank.rawValue)
        XCTAssertEqual("J", rank.abbreviation)
        XCTAssertEqual("J", rank.symbol)
        XCTAssertEqual("Jack", rank.stringValue)
    }
    
    func testRank_Numbers() {
        for value in 2...10 {
            let rank = Rank(rawValue: value)
            
            XCTAssertEqual(value, rank?.rawValue)
            XCTAssertEqual("\(value)", rank?.abbreviation)
            XCTAssertEqual("\(value)", rank?.symbol)
            XCTAssertEqual("\(value)", rank?.stringValue)
        }
    }
    
    func testRank_RawValues() {
        for value in 1...13 {
            let rank = Rank(rawValue: value)
            
            XCTAssertNotNil(rank)
            XCTAssertEqual(value, rank?.rawValue)
        }
        
        let rank = Rank(rawValue: 99)
        XCTAssertNil(rank)
    }
}
