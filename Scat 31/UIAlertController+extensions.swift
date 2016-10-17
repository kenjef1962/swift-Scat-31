//
//  UIAlertController+extensions.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/10/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showAlert(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: GlobalStrings.scat31, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: GlobalStrings.ok, style: .default, handler: nil)
        
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
