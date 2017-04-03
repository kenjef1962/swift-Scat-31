//
//  Scat_31Tests.swift
//  Scat 31Tests
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class Scat_31Tests: XCTestCase {
    func testPlayer_Computer() {
        let player = Player.computer
        
        XCTAssertEqual("C", player.abbreviation)
        XCTAssertEqual("🖥", player.symbol)
        XCTAssertEqual("Computer", player.stringValue)
    }

    func testPlayer_Player() {
        let player = Player.player

        XCTAssertEqual("P", player.abbreviation)
        XCTAssertEqual("👤", player.symbol)
        XCTAssertEqual("Player", player.stringValue)
    }
    
    func testPlayer_RawValues() {
        for value in 0..<2 {
            let player = Player(rawValue: value)
            
            XCTAssertNotNil(player)
            XCTAssertEqual(value, player?.rawValue)
        }
        
        let player = Rank(rawValue: 99)
        XCTAssertNil(player)
    }
}
