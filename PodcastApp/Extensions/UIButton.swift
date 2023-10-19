//
//  UIBUtton.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/28/23.
//

import UIKit

extension UIButton {
    
    convenience init(normalStateText: String, normalStateTextColor: UIColor, backgroundColor: UIColor) {
        self.init()
        self.setTitleColor(normalStateTextColor, for: .normal)
        self.setTitle(normalStateText, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
}
