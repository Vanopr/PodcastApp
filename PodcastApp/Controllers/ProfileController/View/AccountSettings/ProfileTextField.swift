//
//  ProfileTextField.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 01.10.2023.
//

import UIKit
import SnapKit

class ProfileTextField: UIView {
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .gray
		label.font = UIFont.manropeRegular(size: 14)
		return label
	}()
	
	lazy var textField: UITextField = {
		let textField = UITextField()
		//        textField.borderStyle = .line
		textField.layer.borderWidth = 1.0
		textField.clipsToBounds = true
		textField.layer.cornerRadius = 26
		textField.layer.borderColor = UIColor.lightBlue.cgColor
		let padding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
		textField.leftView = padding
		textField.rightView = padding
		textField.leftViewMode = .always
		textField.rightViewMode = .always
		return textField
	}()
	
	private lazy var calendarButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "Calendar"), for: .normal)
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		addConstraints()
	}
	
	convenience init(title: String, buttonIsHidden: Bool = true) {
		self.init(frame: .zero)
		calendarButton.isHidden = buttonIsHidden
		titleLabel.text = title
		paddingConfigure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func paddingConfigure() {
		if calendarButton.isHidden == false {
			textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 0))
		}
	}
}

// MARK: - Layout
private extension ProfileTextField {
	func addSubviews() {
		addSubview(titleLabel)
		addSubview(textField)
		textField.addSubview(calendarButton)
	}
	
	func addConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
		}
		
		textField.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
			make.height.equalTo(52)
		}
		
		calendarButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().offset(-15)
		}
	}
}
