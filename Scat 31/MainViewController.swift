//
//  MainViewController.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {

    // MARK: Display Outlets
    @IBOutlet weak var computerLabel: UILabel!
    @IBOutlet weak var computerCard1: UIButton!
    @IBOutlet weak var computerCard2: UIButton!
    @IBOutlet weak var computerCard3: UIButton!
    @IBOutlet weak var computerCard4: UIButton!
    @IBOutlet weak var computerBestHand: UILabel!
    @IBOutlet weak var computerWins: UILabel!
    @IBOutlet weak var computerKnock: UILabel!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var playerCard1: UIButton!
    @IBOutlet weak var playerCard2: UIButton!
    @IBOutlet weak var playerCard3: UIButton!
    @IBOutlet weak var playerCard4: UIButton!
    @IBOutlet weak var playerBestHand: UILabel!
    @IBOutlet weak var playerWins: UILabel!
    @IBOutlet weak var playerKnock: UILabel!
    @IBOutlet weak var playerKnockButton: UIButton!

    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var deckButton: UIButton!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var discardCount: UILabel!
    
    // MARK: Private Variables
    fileprivate let gameEngine = GameEngine()
    fileprivate var deckCards: [UIButton] = []
    fileprivate var computerCards: [UIButton] = []
    fileprivate var playerCards: [UIButton] = []
    
    // MARK: Settings Variabled
    fileprivate var playerName = "Player"
    fileprivate var computerName = "Edison"
    
    fileprivate let presenter = MainViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.makeTransparent()
        
        // Do any additional setup after loading the view.
        deckCards = [deckButton, discardButton]
        computerCards = [computerCard1, computerCard2, computerCard3, computerCard4]
        playerCards = [playerCard1, playerCard2, playerCard3, playerCard4]
        
        gameEngine.delegate = self
        gameEngine.startNewMatch()
        
        deckCards.forEach() { card in card.roundedBorders() }
        computerCards.forEach() { card in card.roundedBorders() }
        playerCards.forEach() { card in card.roundedBorders() }
        
        computerName = presenter.randomComputerName
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if presenter.gamesPerMatch <= [gameEngine.winsComputer, gameEngine.winsPlayer].max() ?? 0 {
            UIAlertController.showBasicAlert(title: GlobalStrings.scat31, message: "Gotta reset the match", viewController: self)
            gameEngine.startNewMatch()
        }
        else {
            updateDisplay(showCards: presenter.isDebugMode)
            animateComputerComment()
        }
    }
    
    // MARK: User Actions
    @IBAction func drawFromComputer(_ sender: AnyObject) {
        UIAlertController.showBasicAlert(title: GlobalStrings.scat31_angry, message: GlobalStrings.quitPeaking, viewController: self)
    }
    
    @IBAction func drawCardFromDeck(_ sender: AnyObject) {
        gameEngine.drawCard()
    }
    
    @IBAction func drawCardFromDiscard(_ sender: AnyObject) {
        gameEngine.drawDiscard()
    }
    
    @IBAction func discardCard(_ sender: AnyObject) {
        if let index = sender.tag {
            gameEngine.discardCard(index)
        }
    }
    
    @IBAction func playerKnocks(_ sender: AnyObject) {
        gameEngine.knock()
    }
}

// MARK: Update Display Management
extension MainViewController {
    func updateDisplay(showCards: Bool) {
        updatePlayerDealerAndTurnStatus(gameEngine.currentTurn)
        
        updatePlayerCards(gameEngine.handComputer, cards: computerCards, showCards: showCards)
        updatePlayerCards(gameEngine.handPlayer, cards: playerCards, showCards: true)

        updateBestScores()
        updateWinTotals()
        updateKnockStatus()
        
        updateDeckCount()
        updateDiscardStatus()
    }
    
    func updatePlayerDealerAndTurnStatus(_ player: Player) {
        var computerLabelText = computerName
        var playerLabelText = playerName
        
        if gameEngine.currentDealer == .computer {
            computerLabelText = "\(computerLabelText) \(GlobalStrings.currentDeal)"
        }
        else {
            playerLabelText = "\(playerLabelText) \(GlobalStrings.currentDeal)"
        }
        
        if player == .computer {
            computerLabelText = "\(computerLabelText) \(GlobalStrings.currentTurn)"
        }
        else {
            playerLabelText = "\(playerLabelText) \(GlobalStrings.currentTurn)"
        }
        
        computerLabel.text = computerLabelText
        playerLabel.text = playerLabelText
    }
    
    func updatePlayerCards(_ hand: [Card]?, cards: [UIButton], showCards: Bool) {
        guard let hand = hand else { return }
        
        cards.forEach() { card in
            if let index = cards.index(of: card) {
                if index < hand.count {
                    let cardName = showCards ? hand[index].abbreviation : "CardBack"
                    card.setImage(UIImage(named: cardName), for: .normal)
                }
                else {
                    card.setImage(UIImage(named: "CardPlaceholder"), for: .normal)
                }
            }
        }
    }
    
    func updateBestScores() {
        playerBestHand.text = formatBestScore(player: .player)
    }
    
    fileprivate func formatBestScore(player: Player) -> String {
        let bestScore = gameEngine.getBestScore(player)
        let hand = player == .computer ? gameEngine.handComputer : gameEngine.handPlayer
        
        var text = String(format: GlobalStrings.bestHand, bestScore.symbol)

        if 4 == hand?.count {
            text = "\(text)\(GlobalStrings.beforeDiscard)"
        }
        
        return text
    }
    
    func updateWinTotals() {
        var computerGames = ""
        var playerGames = ""
        
        for game in 1...presenter.gamesPerMatch {
            computerGames = "\(computerGames)\(game <= gameEngine.winsComputer ? GlobalStrings.symbolWin : GlobalStrings.symbolNoWin)"
            playerGames = "\(playerGames)\(game <= gameEngine.winsPlayer ? GlobalStrings.symbolWin : GlobalStrings.symbolNoWin)"
        }
        
        computerWins.text = computerGames
        playerWins.text = playerGames
    }
    
    func updateKnockStatus() {
        if gameEngine.currentKnock == .computer {
            computerKnock.isHidden = false
            computerKnock.text = GlobalStrings.knock
        }
        else  {
            computerKnock.isHidden = !presenter.isDebugMode
            computerKnock.text = presenter.isDebugMode ? String(format: GlobalStrings.knockThreshold, gameEngine.computerThreshold) : ""
        }
        
        playerKnock.isHidden = gameEngine.currentKnock != .player
        playerKnockButton.isHidden = !gameEngine.canPlayerKnock
    }
    
    func updateDeckCount() {
        deckCount.text = "Cards:\n\(gameEngine.deckCardCount)"
        discardCount.text = presenter.isDebugMode ? gameEngine.getDiscardsBySymbol() : ""
    }
    
    func updateDiscardStatus() {
        let cardName = 0 == gameEngine.discardsCardCount ? "CardPlaceholder" : gameEngine.getLastDiscardByAbbreviation()
        discardButton.setImage(UIImage(named: cardName), for: .normal)
    }
}

// MARK: Game Engine Delegates
extension MainViewController: GameEngineDelegate {
    func unexpectedError(_ error: String) {
        UIAlertController.showBasicAlert(title: GlobalStrings.scat31, message: error, viewController: self)
    }
    
    func gameOver(_ player: Player?) {
        var message = ""
        
        if let winner = player {
            var loser = Player.computer
            if winner == .computer {
                loser = .player
            }
            
            let winningScore = gameEngine.getBestScore(winner)
            let losingScore = gameEngine.getBestScore(loser)
            
            message = String(format: GlobalStrings.result_winnerLoser, winner.stringValue, winningScore.symbol, loser.stringValue, losingScore.symbol)
            
            if 31 == winningScore.score {
                message = String(format: GlobalStrings.result_31Wins, message)
            }
        }
        else {
            let bestScore = gameEngine.getBestScore(.player)
            message = String(format: GlobalStrings.result_tieGame, bestScore.score)
        }
        
        message = String(format: GlobalStrings.result_startNewGame, message)
        showStartNewGameAlert(message)
        updateDisplay(showCards: true)
    }
    
    func matchOver(_ player: Player) {
        let message = String(format: GlobalStrings.result_startNewMatch, player.stringValue)
        showStartNewMatchAlert(message)
        
        updateDisplay(showCards: true)
    }
    
    func dealComplete(_ player: Player) {
        updateDisplay(showCards: presenter.isDebugMode)
        animateComputerComment()
    }
    
    func drawCardComplete(_ player: Player) {
        drawComplete(player, srcView: deckButton, showCard: player == .player)
    }
    
    func drawDiscardComplete(_ player: Player) {
        drawComplete(player, srcView: discardButton, showCard: true)
        updateDiscardStatus()
    }
    
    func drawComplete(_ player: Player, srcView: UIButton, showCard: Bool) {
        let destView = (player == .computer) ? computerCards[3] : playerCards[3]
        animateCard(srcView: srcView, destView: destView, showCard: showCard)
        
        if gameEngine.currentTurn == .computer {
            animateComputerComment()
        }
    }
    
    func discardComplete(_ player: Player, index: Int) {
        let srcView = (player == .computer) ? computerCards[index] : playerCards[index]
        animateCard(srcView: srcView, destView: discardButton, showCard: true)
        
        if presenter.isDebugMode {
            animateComputerComment()
        }
    }
    
    func playerKnocked(_ player: Player) {
        playerKnockButton.isHidden = true
        animateKnock(player)
    }
}

// MARK: Animations
extension MainViewController {
    func animateKnock(_ player: Player) {
        guard presenter.isAnimationOn else {
            updateDisplay(showCards: presenter.isDebugMode)
            return
        }
        
        guard let label = player == .computer ? computerKnock : playerKnock else {
            updateDisplay(showCards: presenter.isDebugMode)
            return
        }
        
        label.isHidden = false
        
        UIView.animate(
            withDuration: 0.5,
            delay: player == .player ? 0.0 : 1.0,
            options: [],
            animations: {
                label.textColor = UIColor.red
                label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            },
            completion: { _ in
                label.text = GlobalStrings.knock
                label.textColor = UIColor.black
                label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                
                self.updateDisplay(showCards: self.presenter.isDebugMode)
            })
    }
    
    func animateComputerComment() {
        let comment = presenter.isDebugMode ? formatBestScore(player: .computer) : "\"\(presenter.randomComputerComment)\""
        
        guard presenter.isAnimationOn else {
            computerBestHand.text = comment
            return
        }
        
        let frame = computerBestHand.frame
        
        computerBestHand.alpha = 0.0
        computerBestHand.frame.size = CGSize(width: 0, height: frame.height)
        computerBestHand.text = comment
        
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.computerBestHand.alpha = 1.0
                self.computerBestHand.frame = frame
            },
            completion:  nil)
    }
    
    func animateCard(srcView: UIButton, destView: UIButton, showCard: Bool) {
        guard presenter.isAnimationOn,
            let srcSuperview = srcView.superview,
            let destSuperview = destView.superview
        else {
            updateDisplay(showCards: presenter.isDebugMode)
            return
        }

        let srcImage = showCard ? srcView.imageView?.image : UIImage(named: "CardBack")
        
        let animatedCard = UIImageView()
        animatedCard.center = srcSuperview.convert(srcView.center, to: self.view)
        animatedCard.frame = srcSuperview.convert(srcView.frame, to: self.view)
        animatedCard.image = srcImage
        animatedCard.roundedBorders()
        
        view.addSubview(animatedCard)
        
        destView.isHidden = false
        
        UIView.animate(
            withDuration: Double(0.5),
            animations: {
                animatedCard.center = destSuperview.convert(destView.center, to: self.view)
            },
            completion: { _ in
                animatedCard.removeFromSuperview()
                self.updateDisplay(showCards: self.presenter.isDebugMode)
            })
    }
}

// MARK: Helper Methods
extension MainViewController {
    func showStartNewGameAlert(_ message: String) {
        let alert = UIAlertController(title: GlobalStrings.scat31, message: message, preferredStyle: .alert)
        
        let actionNewGame = UIAlertAction(title: GlobalStrings.newGame, style: .default) { [weak self] _ in self?.gameEngine.startNewGame() }
        alert.addAction(actionNewGame)
        
        let actionNewMatch = UIAlertAction(title: GlobalStrings.newMatch, style: .default) { [weak self] _ in self?.gameEngine.startNewMatch() }
        alert.addAction(actionNewMatch)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showStartNewMatchAlert(_ message: String) {
        let alert = UIAlertController(title: GlobalStrings.scat31, message: message, preferredStyle: .alert)
        
        let actionNewMatch = UIAlertAction(title: GlobalStrings.newMatch, style: .default) { [weak self] _ in self?.gameEngine.startNewMatch() }
        alert.addAction(actionNewMatch)
        
        present(alert, animated: true, completion: nil)
    }
}

