//
//  GenderView.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 02.10.2023.
//

import UIKit
import SnapKit

class GenderView: UIView {
	
	private let maleButton = CheckButton(title: "Male")
	private let femaleButton = CheckButton(title: "Female")
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Gender"
		label.textColor = .gray
		label.font = UIFont.manropeRegular(size: 14)
		return label
	}()
	
	lazy var stackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = 16
		stackView.contentMode = .scaleToFill
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSabviews()
		setupConstraints()
		
		maleButton.addTarget(self, action: #selector(actio), for: .touchUpInside)
		femaleButton.addTarget(self, action: #selector(actio), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func actio(sender: UIButton ) {
		maleButton.isSelected = false
		femaleButton.isSelected = false
		
		sender.isSelected = true
	}
}

// MARK: - Layout
private extension GenderView {
	func addSabviews() {
		addSubview(titleLabel)
		addSubview(stackView)
		stackView.addArrangedSubview(maleButton)
		stackView.addArrangedSubview(femaleButton)
	}
	
	func setupConstraints() {
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
		}
		
		stackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		maleButton.snp.makeConstraints { make in
			make.height.equalTo(48)
		}
		
		femaleButton.snp.makeConstraints { make in
			make.height.equalTo(48)
		}
	}
}
