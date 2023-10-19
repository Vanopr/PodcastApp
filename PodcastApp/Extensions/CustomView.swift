//
//  CustomView.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        backgroundColor = .white
    }
    
    func layoutViews() {
        
    }
}
