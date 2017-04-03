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
    static let scat31_angry = "😡 Scat 31 😡"
    
    static let newGame = "New Game"
    static let newMatch = "New Match"
    static let ok = "OK"
    
    static let symbolWin = "◉"
    static let symbolNoWin = "◎"
    
    static let currentDeal = "🃏"
    static let currentTurn = "◀︎"
    
    static let bestHand = "Best: %@"
    static let beforeDiscard = " ... before discard"
    static let knock = "Knock !!!"
    static let knockThreshold = "Knock threshold: %2.1f"
    static let quitPeaking = "HEY!  Quit trying to peak at my cards!!!"
    
    static let result_31Wins = "Scat diddly dat ... how about that?\n\n%@"
    static let result_tieGame = "Sadly, the game has ended in a tie.\n(Both players had %d pips)"
    static let result_winnerLoser = "%@ wins with %@.\n(%@ had %@)"
    static let result_startNewGame = "%@\n\nDo you want to start a new game or a new match?"
    static let result_startNewMatch = "%@ wins the game and the match.\n\nLet's start a new match."
}

struct GlobalErrors {
    static let unableToDrawCard = "Unable to draw card"
    static let unableToDrawCardWhilKnocking = "Unable to draw card while knocking"
    
    static let invalidNumberCards = "Invalid number of cards in hand"
    static let invalidDiscardIndex = "Invalid discard index"
    static let invalidDiscard = "Invalid discard"
    static let invalidTurn = "Invalid turn by player"
}

struct ComputerNames_Male {
    static let alexander = "Alexander"
    static let edison = "Edison"
    static let john = "John"
    static let kirk = "Kirk"
    static let larry = "Larry"
    static let martin = "Martin"
    static let robert = "Robert"
    static let shawn = "Shawn"
    static let syllvester = "Sylvester"
    static let spartacus = "\"I am Spartacus\""
}

struct ComputerComments {
    static let comment1 = "Fate is smiling down on me"
    static let comment2 = "I'm soooo close now"
    static let comment3 = "Man, do I have a good hand"
    static let comment4 = "If you just knew what I had"
    static let comment5 = "I bet you have nothin' but ninnies"
    static let comment6 = "No way you can beat me"
    static let comment7 = "What to do, oh what to do"
    static let comment8 = "So many good cards to choose from"
    static let comment9 = "Am I good or what"
}
