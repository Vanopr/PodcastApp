//
//  ProfileSettingsButton.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 27.09.2023.
//

import UIKit
import SnapKit

class ProfileSettingsButton: UIButton {
    
    private var imageVie = UIImageView()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .ghostWhite
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(title: String, imageName: UIImage?) {
        self.init()
        self.imageVie.image = imageName
        configuration(with: title)
        addSubviews()
        setupConstraints()
    }
    
    
    private func configuration(with title: String) {
        configuration = .filled()
        configuration?.title = title
        
        var container = AttributeContainer()
        container.font = UIFont.manropeRegular(size: 16)
        
        configuration?.attributedTitle = AttributedString(title, attributes: container)
        
        configuration?.image = UIImage(named: "Stroke")
        
        configuration?.baseBackgroundColor = .white
        configuration?.baseForegroundColor = UIColor.purplyGrey
        configuration?.background.cornerRadius = 12
        configuration?.imagePlacement = .trailing
        contentHorizontalAlignment = .fill
        configuration?.contentInsets.leading = 64
        configuration?.contentInsets.trailing = 22
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }
    
}

// MARK: - Layout
private extension ProfileSettingsButton {
    func addSubviews() {
        addSubview(cardView)
        cardView.addSubview(imageVie)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(48)
        }
        
        imageVie.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
