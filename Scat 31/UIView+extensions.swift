//
//  Utils.swift
//  Scat 31
//
//  Created by Kendall Jefferson on 4/5/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundedBorders(_ borderColor: UIColor = UIColor.black, borderWidth: CGFloat = 1, corneRadius: CGFloat = 5) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = corneRadius
        self.clipsToBounds = true
    }
}
