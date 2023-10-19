//
//  UITextField + Extension.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/28/23.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String = "", borderStyle: UITextField.BorderStyle) {
        self.init()
        self.placeholder = placeholder
        self.borderStyle = borderStyle
    }
    
    //  MARK: Round UITextField
    convenience init(placeHolder: String, textColor: UIColor, backGroundColor: UIColor) {
        self.init()
        self.borderStyle = .none
        self.placeholder = placeHolder
        self.textColor = .gray
        self.backgroundColor = .ghostWhite
        self.layer.cornerRadius = 18
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftViewMode = .always
    }
}
