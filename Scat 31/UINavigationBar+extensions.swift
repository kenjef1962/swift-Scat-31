//
//  UINavigationBar+extensions.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/2/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func makeTransparent() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
