//
//  SettingsViewController.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/10/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var animationSwitch: UISwitch!
    @IBOutlet weak var debugModeSwitch: UISwitch!
    @IBOutlet weak var gamesSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.makeTransparent()
        
        let defaults = UserDefaults.standard
        animationSwitch.isOn = defaults.bool(forKey: "AnimationOn")
        debugModeSwitch.isOn = defaults.bool(forKey: "DebugMode")
        
        let gamesPerMatch = defaults.integer(forKey: "GamesPerMatch") - 3
        gamesSegment.selectedSegmentIndex = gamesPerMatch
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = UserDefaults.standard
        defaults.set(animationSwitch.isOn, forKey: "AnimationOn")
        defaults.set(debugModeSwitch.isOn, forKey: "DebugMode")
        
        let gamePerMatch = gamesSegment.selectedSegmentIndex + 3
        defaults.set(gamePerMatch, forKey: "GamesPerMatch")
    }
}
