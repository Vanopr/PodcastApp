//
//  ProfileInfo.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 28.09.2023.
//

import UIKit
import SnapKit



class ProfileInfo: UIView {
	
	private let firstName = ProfileTextField(title: "First Name")
	private let lasttName = ProfileTextField(title: "Last Name")
	private let eMail = ProfileTextField(title: "E-Mail")
	private let dateOfBirth = ProfileTextField(title: "Date of Birth", buttonIsHidden: false)
	private let genderView = GenderView()
	
	lazy var stackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 16
		stackView.contentMode = .scaleToFill
		return stackView
	}()
    
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		addConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

private extension ProfileInfo {
	func addSubviews() {
		addSubview(stackView)
		stackView.addArrangedSubview(firstName)
		stackView.addArrangedSubview(lasttName)
		stackView.addArrangedSubview(eMail)
		stackView.addArrangedSubview(dateOfBirth)
		stackView.addArrangedSubview(genderView)
        
	}
	
	func addConstraints() {
		stackView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
//			make.bottom.equalToSuperview()
		}
	}
}
