//
//  UIbutton + Extension.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/26/23.
//

import UIKit

extension UIButton {
    
    convenience init(normalStateText: String, backgroundColor: UIColor) {
        self.init()
        self.setTitle(normalStateText, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
}
