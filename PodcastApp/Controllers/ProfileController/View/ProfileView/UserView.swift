//
//  UserView.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 27.09.2023.
//

import UIKit
import SnapKit

class UserView: UIView {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .palePink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .manropeExtraBold(size: 16)
        label.text = "Ivan Ivanov"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .manropeRegular(size: 14)
        label.text = "Love, Life, Chill."
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 0, alpha: 0)
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(cardView).offset(32)
            make.centerY.equalTo(cardView)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalTo(cardView).offset(32)
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.centerY.equalTo(cardView)
        }
        
    }
}
