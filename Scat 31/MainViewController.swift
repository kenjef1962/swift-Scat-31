//
//  MainViewController.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit
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


class MainViewController: UIViewController {

    // MARK: Display Outlets
    @IBOutlet weak var computerLabel: UILabel!
    @IBOutlet weak var computerCard1: UILabel!
    @IBOutlet weak var computerCard2: UILabel!
    @IBOutlet weak var computerCard3: UILabel!
    @IBOutlet weak var computerCard4: UILabel!
    @IBOutlet weak var computerBestHand: UILabel!
    @IBOutlet weak var computerWins: UILabel!
    @IBOutlet weak var computerKnock: UILabel!
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerCard1: UILabel!
    @IBOutlet weak var playerCard2: UILabel!
    @IBOutlet weak var playerCard3: UILabel!
    @IBOutlet weak var playerCard4: UILabel!
    @IBOutlet weak var playerBestHand: UILabel!
    @IBOutlet weak var playerWins: UILabel!
    @IBOutlet weak var playerKnock: UILabel!
    @IBOutlet weak var playerKnockButton: UIButton!
    
    @IBOutlet weak var playerDiscard1: UIButton!
    @IBOutlet weak var playerDiscard2: UIButton!
    @IBOutlet weak var playerDiscard3: UIButton!
    @IBOutlet weak var playerDiscard4: UIButton!
    
    @IBOutlet weak var deckCount: UILabel!
    @IBOutlet weak var discardPile: UILabel!
    @IBOutlet weak var lastDiscardCard: UILabel!
    
    // MARK: Private Variables
    fileprivate let gameEngine = GameEngine()
    fileprivate var computerCards: [UILabel] = []
    
    fileprivate var playerCards: [UILabel] = []
    fileprivate var playerDiscards: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        computerCards = [computerCard1, computerCard2, computerCard3, computerCard4]
        
        playerCards = [playerCard1, playerCard2, playerCard3, playerCard4]
        playerDiscards = [playerDiscard1, playerDiscard2, playerDiscard3, playerDiscard4]
        
        gameEngine.delegate = self
        gameEngine.startNewMatch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}

// MARK: User Actions
extension MainViewController {
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
    func updateDisplay() {
        updatePlayerDealerAndTurnStatus(gameEngine.currentTurn)
        
        updatePlayerCards(gameEngine.getHand(.computer), cards: computerCards)
        updatePlayerCards(gameEngine.getHand(.player), cards: playerCards)
        updatePlayerDiscardButtons()

        updateBestScores()
        updateWinTotals()
        updateKnockStatus()
        
        updateDeckCount()
        updateDiscardStatus()
    }
    
    func updatePlayerDealerAndTurnStatus(_ player: Player) {
        var computerLabelText = "Computer"
        var playerLabelText = "Player"
        
        if (gameEngine.currentDealer == .computer) {
            computerLabelText = "\(computerLabelText)\(GlobalStrings.currentDeal)"
        }
        else {
            playerLabelText = "\(playerLabelText)\(GlobalStrings.currentDeal)"
        }
        
        if (player == .computer) {
            computerLabelText = "\(computerLabelText) \(GlobalStrings.currentTurn)"
        }
        else {
            playerLabelText = "\(playerLabelText) \(GlobalStrings.currentTurn)"
        }
        
        computerLabel.text = computerLabelText
        playerLabel.text = playerLabelText
    }
    
    func updatePlayerCards(_ hand: [Card]?, cards: [UILabel]) {
        for index in 0..<cards.count {
            if (index < hand?.count) {
                cards[index].text = hand?[index].symbol
            }
            else {
                cards[index].text = "---"
            }
        }
    }
    
    func updatePlayerDiscardButtons() {
        for button in playerDiscards {
            button.isHidden = !gameEngine.canPlayerDiscard
        }
    }
    
    func updateBestScores() {
        var bestScore = gameEngine.getBestScore(.computer)
        computerBestHand.text = "Best: \(bestScore.score)\(bestScore.suit.symbol)"
        
        bestScore = gameEngine.getBestScore(.player)
        playerBestHand.text = "Best: \(bestScore.score)\(bestScore.suit.symbol)"
    }
    
    func updateWinTotals() {
        var computerGames = ""
        var playerGames = ""
        
        for game in 1...5 {
            computerGames = "\(computerGames)\(game <= gameEngine.winsComputer ? GlobalStrings.symbolWin : GlobalStrings.symbolNoWin)"
            playerGames = "\(playerGames)\(game <= gameEngine.winsPlayer ? GlobalStrings.symbolWin : GlobalStrings.symbolNoWin)"
        }
        
        computerWins.text = computerGames
        playerWins.text = playerGames
    }
    
    func updateKnockStatus() {
        if (gameEngine.currentKnock == .computer) {
            computerKnock.text = "Knocked !!!"
        }
        else {
            computerKnock.text = "Knock threshold @ \(gameEngine.computerKnockThreshold)"
        }
        
        playerKnock.isHidden = gameEngine.currentKnock != .player
        playerKnockButton.isHidden = gameEngine.canPlayerKnock
    }
    
    func updateDeckCount() {
        deckCount.text = "\(gameEngine.deckCardCount)"
    }
    
    func updateDiscardStatus() {
        //lastDiscardCard.text = "Last: \(gameEngine.showLastDiscard())"
        discardPile.text = gameEngine.showDiscards()
    }
}

// MARK: Game Engine Delegates
extension MainViewController: GameEngineDelegate {
    func unexpectedError(_ error: String) {
        print("\(#function) - Error: \(error)")
        
        UIAlertController.showBasicAlert(error, viewController: self)
    }
    
    func gameOver(_ player: Player?) {
        print("\(#function) - Player: \(player)")
        
        var message = ""
        
        if let player = player {
            let bestScore = gameEngine.getBestScore(player)
            
            message = "\(player.stringValue) wins with \(bestScore.symbol)"
            
            if bestScore.score == 31 {
                message = "Scat diddly dat ... how about that?\n\n\(message)!!!"
            }
            else {
                message = "\(message)."
            }
        }
        else {
            message = "The game has ended in a tie."
        }
        
        showStartNewGameAlert("\(message)\n\nDo you want to start a new game or a new match?")
        updateDisplay()
    }
    
    func matchOver(_ player: Player) {
        print("\(#function) - Player: \(player)")
        
        showStartNewMatchAlert("\(player.stringValue) wins this match.\n\nLet's start a new match.")
        updateDisplay()
    }
    
    func dealComplete(_ player: Player) {
        print("-----\n\(#function) - Player: \(player)")
        
        updateDisplay()
    }
    
    func drawCardComplete(_ player: Player) {
        print("\(#function) - Player: \(player)")
        
        updateDisplay()
        // TODO: Animate draw card from deck
    }
    
    func drawDiscardComplete(_ player: Player) {
        print("\(#function) - Player: \(player)")
        
        updateDisplay()
        // TODO: Animate draw card from discard
    }
    
    func discardComplete(_ player: Player, index: Int) {
        print("\(#function) - Player: \(player), Index: \(index)")
        
        updateDisplay()
        // TODO: Animate discard
    }
    
    func playerKnocked(_ player: Player) {
        print("\(#function) - Player: \(player)")
        
        updateDisplay()

        animateKnock(player == .computer ? computerKnock : playerKnock)
    }
}

// MARK: Animations
extension MainViewController {
    func animateKnock(_ label: UILabel) {
        UIView.animate(withDuration: 0.5,
        animations: {
            label.textColor = UIColor.red
            label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        },
        completion: { _ in
            label.textColor = UIColor.black
            label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
}

// MARK: Helper Methods
extension MainViewController {
    func showStartNewGameAlert(_ message: String) {
        let alert = UIAlertController(title: GlobalStrings.scat31, message: message, preferredStyle: .alert)
        
        let actionNewGame = UIAlertAction(title: GlobalStrings.newGame, style: .default) { _ in self.gameEngine.startNewGame() }
        alert.addAction(actionNewGame)
        
        let actionNewMatch = UIAlertAction(title: GlobalStrings.newMatch, style: .default) { _ in self.gameEngine.startNewMatch() }
        alert.addAction(actionNewMatch)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showStartNewMatchAlert(_ message: String) {
        let alert = UIAlertController(title: GlobalStrings.scat31, message: message, preferredStyle: .alert)
        
        let actionNewMatch = UIAlertAction(title: GlobalStrings.newMatch, style: .default) { _ in self.gameEngine.startNewMatch() }
        alert.addAction(actionNewMatch)
        
        present(alert, animated: true, completion: nil)
    }
}

