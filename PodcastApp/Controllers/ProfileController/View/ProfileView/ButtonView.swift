//
//  ButtonView.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 27.09.2023.
//

import UIKit
import SnapKit

protocol ButtonViewDelegate: AnyObject {
    func didSelectButton()
}

class ButtonView: UIView {
    
    weak var delegate: ButtonViewDelegate?
    
    private let profileSettingsButton = ProfileSettingsButton(title: "Account Settings", imageName: UIImage(named: "ProfileImg"))
    private let profileChangePasswordButton = ProfileSettingsButton(title: "Change Password", imageName: UIImage(named: "Shield"))
    private let profileForgetPasswordButton = ProfileSettingsButton(title: "Forget Password", imageName: UIImage(named: "Lock"))
    
    private var stackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 21
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        profileSettingsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        delegate?.didSelectButton()
    }

}

private extension ButtonView {
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(profileSettingsButton)
        stackView.addArrangedSubview(profileChangePasswordButton)
        stackView.addArrangedSubview(profileForgetPasswordButton)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
