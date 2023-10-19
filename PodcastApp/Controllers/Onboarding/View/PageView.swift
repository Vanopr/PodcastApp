//
//  PageView.swift
//  PodcastApp
//
//  Created by Aleksandr Garipov on 27.09.2023.
//

enum PageViewType {
    case first
    case second
    case last
}

import UIKit
import SnapKit

class PageView: CustomView {
    
    weak var delegate: PageViewDelegate?
    
    //MARK: - UI Elements
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "firstPageLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.onboardBackgroundViewColor
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.numberOfLines = 0
        label.text = """
        SUPER APP
        SUPER APP
        SUPER APP
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = """
        SUPER APP SUPER APP SUPER APP
        SUPER APP SUPER APP SUPER APP
        SUPER APP SUPER APP SUPER APP
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.tintColor = .black
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1536328793, green: 0.5095483661, blue: 0.9458360076, alpha: 1)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackOfButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Life Cycle
    
    override func setViews() {
        super.setViews()
        addSubview(logoImageView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        stackOfButtons.addArrangedSubview(skipButton)
        stackOfButtons.addArrangedSubview(spacingView)
        stackOfButtons.addArrangedSubview(nextButton)
        contentView.addSubview(stackOfButtons)
    }
    
    override func layoutViews() {
        super.layoutViews()
        setLayout()
        logoImageView.layer.cornerRadius = self.frame.height / 2
        logoImageView.clipsToBounds = true
    }
    
    //MARK: - Actions
    
    @objc
    private func nextButtonPressed() {
        delegate?.nextButtonPressed()
    }
    
    @objc
    private func skipButtonPressed() {
        delegate?.skipButtonPressed()
    }
    
    //MARK: - Methods
    
    func configureView(with type: PageViewType) {
        switch type {
        case .first:
            break
        case .second:
            logoImageView.image = UIImage(named: "secondPageLogo")
        case .last:
            logoImageView.image = UIImage(named: "lastPageLogo")
            skipButton.removeFromSuperview()
            nextButton.removeFromSuperview()
            spacingView.removeFromSuperview()
            stackOfButtons.addArrangedSubview(startButton)
            layoutIfNeeded()
        }
    }
    
    private func setLayout() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(68)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(85)
        }
        
        skipButton.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(85)
        }
        
        spacingView.snp.makeConstraints { make in
            make.height.equalTo(58)
            make.width.equalTo(90)
        }
        
        stackOfButtons.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
    }
}
