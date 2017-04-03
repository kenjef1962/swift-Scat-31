//
//  MainViewPresenter.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 3/26/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

class MainViewPresenter {
    fileprivate let computerNames = [
        ComputerNames_Male.alexander,
        ComputerNames_Male.edison,
        ComputerNames_Male.john,
        ComputerNames_Male.kirk,
        ComputerNames_Male.larry,
        ComputerNames_Male.martin,
        ComputerNames_Male.robert,
        ComputerNames_Male.shawn,
        ComputerNames_Male.syllvester,
        ComputerNames_Male.spartacus,
    ]
    
    var randomComputerName: String {
        get {
            let index = Int(arc4random_uniform(UInt32(computerNames.count)))
            return computerNames[index]
        }
    }
    
    fileprivate let computerComments = [
        ComputerComments.comment1,
        ComputerComments.comment2,
        ComputerComments.comment3,
        ComputerComments.comment4,
        ComputerComments.comment5,
        ComputerComments.comment6,
        ComputerComments.comment7,
        ComputerComments.comment8,
        ComputerComments.comment9
    ]
    
    var randomComputerComment: String {
        get {
            let index = Int(arc4random_uniform(UInt32(computerComments.count)))
            return computerComments[index]
        }
    }
    
    var isAnimationOn: Bool {
        let key = "AnimationOn"
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: key) == nil {
            defaults.set(true, forKey: key)
        }
        
        return defaults.bool(forKey: key)
    }
    
    var isDebugMode: Bool {
        let key = "DebugMode"
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: key) == nil {
            defaults.set(false, forKey: key)
        }
        
        return defaults.bool(forKey: key)
    }
    
    var gamesPerMatch: Int {
        let key = "GamesPerMatch"
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: key) == nil {
            defaults.set(5, forKey: key)
        }
        
        return defaults.integer(forKey: key)
    }
}
