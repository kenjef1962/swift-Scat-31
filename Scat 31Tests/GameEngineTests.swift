//
//  GameEngineTests.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 11/9/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import XCTest
@testable import Scat_31

class GameEngineTests: XCTestCase {
    var gameEngine: GameEngine?

    override func setUp() {
        gameEngine = GameEngine()
    }
    
    func testGameEngine_Init() {
        guard let gameEngine = gameEngine else {
            XCTAssert(false, "Setup Failure");
            return
        }

        XCTAssertNil(gameEngine.delegate)

        // Deck & Discards
        XCTAssertEqual(52, gameEngine.deckCardCount)
        XCTAssertEqual(0, gameEngine.discardsCardCount)
        
        // Computer
        XCTAssertNotNil(gameEngine.handComputer)
        XCTAssertEqual(0, gameEngine.handComputer?.count)
        XCTAssertEqual(0, gameEngine.winsComputer)
        XCTAssertTrue(0 <= gameEngine.computerThreshold)
        
        XCTAssertFalse(gameEngine.checkForWinner(.computer))
        XCTAssertTrue(gameEngine.checkForValidConditions(.computer, expectedCardCount: 0))

        var bestScore = gameEngine.getBestScore(.computer)
        XCTAssertEqual(0, bestScore.score)
        XCTAssertEqual(Suit.clubs, bestScore.suit)
        XCTAssertEqual("0-♣️", bestScore.symbol)
        
        // Player
        XCTAssertNotNil(gameEngine.handPlayer)
        XCTAssertEqual(0, gameEngine.handPlayer?.count)
        XCTAssertEqual(0, gameEngine.winsPlayer)
        
        XCTAssertFalse(gameEngine.canPlayerDiscard)
        XCTAssertFalse(gameEngine.canPlayerKnock)
        
        XCTAssertFalse(gameEngine.checkForWinner(.player))
        XCTAssertTrue(gameEngine.checkForValidConditions(.player, expectedCardCount: 0))
        
        bestScore = gameEngine.getBestScore(.player)
        XCTAssertEqual(0, bestScore.score)
        XCTAssertEqual(Suit.clubs, bestScore.suit)
        XCTAssertEqual("0-♣️", bestScore.symbol)
        
        // Current Game
        XCTAssertEqual(Player.player, gameEngine.currentDealer)
        XCTAssertEqual(Player.computer, gameEngine.currentTurn)
        XCTAssertNil(gameEngine.determineWinner())
    }
    
    func testGameEngine_NewGame() {
        guard let gameEngine = gameEngine else {
            XCTAssert(false, "Setup Failure");
            return
        }

        gameEngine.startNewGame()
        
        // Deck & Discards
        XCTAssertEqual(46, gameEngine.deckCardCount)
        XCTAssertEqual(0, gameEngine.discardsCardCount)
        
        // Computer
        XCTAssertNotNil(gameEngine.handComputer)
        XCTAssertEqual(3, gameEngine.handComputer?.count)
        XCTAssertEqual(0, gameEngine.winsComputer)
        XCTAssertTrue(26 <= gameEngine.computerThreshold)
        
        var bestScore = gameEngine.getBestScore(.computer)
        XCTAssertTrue(2 <= bestScore.score && bestScore.score <= 31)

        // Player
        XCTAssertNotNil(gameEngine.handPlayer)
        XCTAssertEqual(3, gameEngine.handPlayer?.count)
        XCTAssertEqual(0, gameEngine.winsPlayer)
        
        bestScore = gameEngine.getBestScore(.player)
        XCTAssertTrue(2 <= bestScore.score && bestScore.score <= 31)

        XCTAssertFalse(gameEngine.canPlayerDiscard)
        XCTAssertTrue(gameEngine.canPlayerKnock)
        
        // Current Game
        XCTAssertEqual(Player.computer, gameEngine.currentDealer)
        XCTAssertEqual(Player.player, gameEngine.currentTurn)
        
        // New Game - Switch Deal & Turn
        //let winner = gameEngine.determineWinner()
        //gameEngine.startNewGame()
        //
        //if (winner == .player) {
        //    XCTAssertEqual(Player.player, gameEngine.currentDealer)
        //    XCTAssertEqual(Player.computer, gameEngine.currentTurn)
        //}
        //else {
        //    XCTAssertEqual(Player.computer, gameEngine.currentDealer)
        //    XCTAssertEqual(Player.player, gameEngine.currentTurn)
        //}
    }

    
    func testGameEngine_DrawAndDiscard() {
        guard let gameEngine = gameEngine else {
            XCTAssert(false, "Setup Failure");
            return
        }
        
        gameEngine.startNewGame()
        
        // Current Game
        XCTAssertEqual(Player.computer, gameEngine.currentDealer)
        XCTAssertEqual(Player.player, gameEngine.currentTurn)
        
        // Player Draw & Discard
        gameEngine.drawCard()
        
        // Card Stack Counts
        XCTAssertEqual(45, gameEngine.deckCardCount)
        XCTAssertEqual(0, gameEngine.discardsCardCount)
        XCTAssertEqual(3, gameEngine.handComputer?.count)
        XCTAssertEqual(4, gameEngine.handPlayer?.count)
        XCTAssertFalse(gameEngine.canPlayerKnock)
        XCTAssertTrue(gameEngine.canPlayerDiscard)
        
        XCTAssertEqual(Player.player, gameEngine.currentTurn)
        
        gameEngine.discardCard(0)
        
        // Card Stack Counts
        XCTAssertEqual(45, gameEngine.deckCardCount)
        XCTAssertEqual(1, gameEngine.discardsCardCount)
        XCTAssertEqual(3, gameEngine.handComputer?.count)
        XCTAssertEqual(3, gameEngine.handPlayer?.count)
        XCTAssertFalse(gameEngine.canPlayerKnock)
        XCTAssertFalse(gameEngine.canPlayerDiscard)

        XCTAssertEqual(Player.computer, gameEngine.currentTurn)
        
        // Computer Draw and Discard
        gameEngine.drawCard()
        
        // Deck & Discards
        XCTAssertEqual(44, gameEngine.deckCardCount)
        XCTAssertEqual(1, gameEngine.discardsCardCount)
        XCTAssertEqual(4, gameEngine.handComputer?.count)
        XCTAssertEqual(3, gameEngine.handPlayer?.count)
        XCTAssertFalse(gameEngine.canPlayerKnock)
        XCTAssertFalse(gameEngine.canPlayerDiscard)
        
        XCTAssertEqual(Player.computer, gameEngine.currentTurn)
        
        gameEngine.discardCard(0)
        
        // Deck & Discards
        XCTAssertEqual(44, gameEngine.deckCardCount)
        XCTAssertEqual(2, gameEngine.discardsCardCount)
        XCTAssertEqual(3, gameEngine.handComputer?.count)
        XCTAssertEqual(3, gameEngine.handPlayer?.count)
        XCTAssertTrue(gameEngine.canPlayerKnock)
        XCTAssertFalse(gameEngine.canPlayerDiscard)
        
        XCTAssertEqual(Player.player, gameEngine.currentTurn)
    }
}
