//
//  GlobalStrings.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation

struct GlobalStrings {
    static let scat31 = "Scat 31"
    
    static let newGame = "New Game"
    static let newMatch = "New Match"
    static let ok = "OK"
    
    
    static let symbolWin = "◉"
    static let symbolNoWin = "◎"
    
    static let currentDeal = "🃏"
    static let currentTurn = "◁"
}

struct GlobalErrors {
    static let unableToDrawCard = "Unable to draw card"
    static let unableToDrawCardWhilKnocking = "Unable to draw card while knocking"
    static let invalidNumberCards = "Invalid number of cards in hand"
    static let invalidDiscardIndex = "Invalid discard index"
    static let invalidDiscard = "Invalid discard"
    static let invalidTurn = "Invalid turn by player"
}
