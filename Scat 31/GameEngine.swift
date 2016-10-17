//
//  GameEngine.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


// MARK: GameEngine Delegate Protocol
protocol GameEngineDelegate {
    func unexpectedError(_ error: String)
    
    func gameOver(_ player: Player?)
    func matchOver(_ player: Player)
    
    func dealComplete(_ player: Player)
    func drawCardComplete(_ player: Player)
    func drawDiscardComplete(_ player: Player)
    func discardComplete(_ player: Player, index: Int)
    
    func playerKnocked(_ player:Player)
}

// MARK: Properties
class GameEngine {
    // MARK: Private Properties
    fileprivate var deck = Deck()
    fileprivate var discards = Discards()
    fileprivate var hands: [Player: [Card]] = [.computer: [Card](), .player: [Card]()]
    fileprivate var wins: [Player: Int] = [.computer: 0, .player: 0]
    
    fileprivate var gameIsOver = false
    fileprivate var lastWinningPlayer: Player?
    
    fileprivate var timer: Timer?
    fileprivate var timerDuration = 0.5
    
    // MARK: Public Properties
    var delegate: GameEngineDelegate?
    
    var currentDeal = Player.player
    var currentTurn = Player.computer
    var currentKnock: Player?
    
    var computerKnockThreshold = 0.0
    
    var winsComputer: Int { get { return wins[.computer] ?? 0 } }
    var winsPlayer: Int { get { return wins[.player] ?? 0 } }
    
    var canPlayerDiscard: Bool { get { return 4 == hands[.player]?.count } }
    var canPlayerKnock: Bool { get { return (currentKnock != nil) || (currentTurn != .player) || (hands[.player]?.count == 4) } }
    
    var deckCardCount: Int { get { return deck.cardCount } }
}

// MARK: Start Games & Matches
extension GameEngine {
    func startNewMatch() {
        clearWins()        
        startNewGame()
    }
    
    func startNewGame() {
        gameIsOver = false
        
        currentDeal = lastWinningPlayer ?? .computer
        currentTurn = currentDeal == .computer ? .player : .computer
        currentKnock = nil
        lastWinningPlayer = nil
        
        computerKnockThreshold = 26.0 + Double(arc4random_uniform(5))
        
        deck.shuffle()
        discards.clearAll()
        
        dealCards()
        
        if (currentTurn == .computer) {
            computerAutoPlay()
        }
    }
}

// MARK: Basic Game Actions
extension GameEngine {
    fileprivate func dealCards() {
        guard !gameIsOver else {
            delegate?.gameOver(lastWinningPlayer); return
        }
        
        clearHands()
        
        for _ in 1...3 {
            guard let card1 = deck.drawCard() else {
                delegate?.unexpectedError(GlobalErrors.unableToDrawCard); return
            }
            guard let card2 = deck.drawCard() else {
                delegate?.unexpectedError(GlobalErrors.unableToDrawCard); return
            }
            
            hands[.computer]?.append((currentDeal == .player) ? card1 : card2)
            hands[.player]?.append((currentDeal == .computer) ? card1 : card2)
        }
        
        delegate?.dealComplete(currentDeal)
    }
    
    func drawCard() {
        drawCard(currentTurn)
    }
    
    func drawCard(_ player: Player) {
        guard checkForValidConditions(player, expectedCardCount: 3) else {
            return
        }
        guard let card = deck.drawCard() else {
            delegate?.unexpectedError(GlobalErrors.unableToDrawCard); return
        }
        
        hands[player]?.append(card)
        
        delegate?.drawCardComplete(player)
    }
    
    func drawDiscard() {
        drawDiscard(currentTurn)
    }

    func drawDiscard(_ player: Player) {
        guard checkForValidConditions(player, expectedCardCount: 3) else {
            return
        }
        guard let card = discards.drawCard() else {
            delegate?.unexpectedError(GlobalErrors.unableToDrawCard); return
        }
        
        hands[player]?.append(card)
        
        delegate?.drawDiscardComplete(player)
    }
    
    func discardCard(_ index: Int) {
        discardCard(currentTurn, index: index)
    }
    
    func discardCard(_ player: Player, index: Int) {
        guard checkForValidConditions(player, expectedCardCount: 4) else {
            return
        }
        guard (0 <= index) && (index <= 3) else {
            delegate?.unexpectedError(GlobalErrors.invalidDiscardIndex); return
        }
        
        if let card = hands[player]?[index] {
            if currentKnock == nil {
                guard card.symbol != discards.lastCard?.symbol else {
                    delegate?.unexpectedError(GlobalErrors.invalidDiscard); return
                }
            }
            
            hands[player]?.remove(at: index)
            discards.addCard(card)
        }
        
        currentTurn = (player == .computer) ? .player : .computer
        
        if !checkForWinner(player) {
            delegate?.discardComplete(player, index: index)
            
            if (currentTurn == .computer) {
                computerAutoPlay()
            }
        }
    }
    
    func knock() {
        knock(currentTurn)
    }
    
    func knock(_ player: Player) {
        guard checkForValidConditions(player, expectedCardCount: 3) else {
            return
        }
        
        currentTurn = (player == .computer) ? .player : .computer
        currentKnock = player
        
        delegate?.playerKnocked(player)
        
        if (currentTurn == .computer) {
            computerAutoPlay()
        }
    }
    
    func checkForValidConditions(_ player: Player, expectedCardCount: Int) -> Bool {
        guard !gameIsOver else {
            delegate?.gameOver(lastWinningPlayer); return false
        }
        guard currentKnock != player else {
            delegate?.unexpectedError(GlobalErrors.unableToDrawCardWhilKnocking); return false
        }
        guard hands[player]?.count == expectedCardCount else {
            delegate?.unexpectedError(GlobalErrors.invalidNumberCards); return false
        }
        
        return true
    }
}

// MARK: Computer Auto Play
extension GameEngine {
    func computerAutoPlay() {
        if (currentKnock == nil) {
            let bestScore = getBestScore(.computer)
            
            if (bestScore.score >= Int(computerKnockThreshold)) {
                currentTurn = .player
                currentKnock = .computer
                
                delegate?.playerKnocked(.computer)
                return
            }
        }

        computerKnockThreshold = computerKnockThreshold - 0.5
        
        if computerShouldDrawDiscard() {
            self.timer = Timer.scheduledTimer(timeInterval: timerDuration, target: self, selector: #selector(computerDrawDiscard(_:)), userInfo: "", repeats: false)
        }
        else {
            self.timer = Timer.scheduledTimer(timeInterval: timerDuration, target: self, selector: #selector(computerDraw(_:)), userInfo: "", repeats: false)
        }
    }
    
    fileprivate func computerShouldDrawDiscard() -> Bool {
        // Determine if we draw or pick up discard
        if (discards.cardCount == 0) {
            return false
        }
        else if (discards.topCard?.value < 5) {
            return false
        }
        else if let topCard = discards.topCard {
            let bestScorePre = getBestScore(.computer)
            hands[.computer]?.append(topCard)
            
            let bestScorePost = getBestScore(.computer)
            hands[.computer]?.removeLast()
            
            if (bestScorePre.score >= bestScorePost.score) {
                return false
            }
        }
        
        return true
    }
    
    @objc func computerDraw(_ timer: Timer) {
        drawCard()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(computerDiscards(_:)), userInfo: "", repeats: false)
    }
    
    @objc func computerDrawDiscard(_ timer: Timer) {
        drawDiscard()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(computerDiscards(_:)), userInfo: "", repeats: false)
    }
    
    @objc func computerDiscards(_ timer: Timer) {
        var possibleDiscards = [Card]()
        
        if let cards = hands[.computer] {
            let bestScore = getBestScore(.computer)
            
            for card in cards {
                if (card.suit != bestScore.suit) {
                    possibleDiscards.append(card)
                }
            }
            
            if (possibleDiscards.count == 0) {
                possibleDiscards = cards
            }
            
            var smallestCard: Card? = nil
            for card2 in possibleDiscards {
                if ((smallestCard == nil) || (card2.value < smallestCard?.value)) {
                    smallestCard = card2
                }
            }
            
            let index = cards.index() {
                return ($0.suit == smallestCard!.suit) && ($0.value == smallestCard!.value)
            }
            
            discardCard(index!)
        }
    }
}

// MARK: Game Scoring & Winner Rules
extension GameEngine {
    func getBestScore(_ player: Player) -> (score: Int, suit: Suit, symbol: String) {
        var indexSuit = 0
        var bestScore = 0
        
        if let handToScore = hands[player] {
            var scores = [0, 0, 0, 0]
            
            for card in handToScore {
                scores[card.suit.rawValue] += card.value
            }
            
            for index in 0..<scores.count {
                if (bestScore < scores[index]) {
                    bestScore = scores[index]
                    indexSuit = index
                }
            }
        }
        
        let suit = Suit(rawValue: indexSuit)!
        
        return (score: bestScore, suit: suit, symbol: "\(bestScore)\(suit.symbol)")
    }
    
    func checkForWinner(_ player: Player) -> Bool {
        let bestScore = getBestScore(player)
        
        if (bestScore.score == 31) {
            lastWinningPlayer = player
            updateWinner(lastWinningPlayer)
            return true
        }
        
        if (currentKnock == currentTurn) {
            lastWinningPlayer = determineWinner()
            updateWinner(lastWinningPlayer)
            return true
        }
        
        return false
    }
    
    func determineWinner() -> Player? {
        var winner: Player?
        
        let bestScoreComputer = getBestScore(.computer)
        let bestScorePlayer = getBestScore(.player)
        
        if (bestScoreComputer.score > bestScorePlayer.score) {
            winner = .computer
        }
        else if (bestScoreComputer.score < bestScorePlayer.score) {
            winner = .player
        }
        
        return winner
    }
    
    func updateWinner(_ winner: Player?) {
        gameIsOver = true
        
        if let winner = winner {
            let winsPlayer = wins[winner] ?? 0
            wins[winner] = winsPlayer + 1
            
            if (5 == wins[winner]) {
                delegate?.matchOver(winner)
                return
            }
        }
        
        delegate?.gameOver(lastWinningPlayer)
    }
}

// MARK: Helper Methods
extension GameEngine {
    func clearHands() {
        hands[.computer]?.removeAll(keepingCapacity: true)
        hands[.player]?.removeAll(keepingCapacity: true)
    }
    
    func clearWins() {
        wins[.computer]? = 0
        wins[.player]? = 0
    }
    
    func getHand(_ player: Player) -> [Card]? {
        return hands[player]
    }
    
    func showDeck() -> String {
        return deck.showCards()
    }
    
    func showDiscards() -> String {
        return discards.showCards()
    }
    
    func showTopDiscard() -> String {
        return discards.topCard?.symbol ?? "---"
    }
    
    func showLastDiscard() -> String {
        return discards.lastCard?.symbol ?? "---"
    }
}
