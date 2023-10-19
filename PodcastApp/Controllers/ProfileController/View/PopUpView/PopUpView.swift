//
//  PopUpView.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 02.10.2023.
//

import UIKit
import SnapKit

class PopUpView: UIView {
	
	private let takePhotoButton = PopUpButton(title: "Take a photo", imageName: "Camera")
	private let choosePhotoButton = PopUpButton(title: "Choose from your file", imageName: "PhotoLibrary")
	private let deletePhotoButton = PopUpButton(title: "Delete Photo", imageName: "Delete")
	
	private let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = .gray
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Change your picture"
		label.textAlignment = .center
		label.textColor = .black
		label.font = UIFont.manropeRegular(size: 20)
		return label
	}()
	
	
	lazy var stackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 20
		stackView.contentMode = .scaleAspectFit
		return stackView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		setupConstraints()
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		backgroundColor = .white
		layer.cornerRadius = 12
	}
}

// MARK: - Layout
private extension PopUpView {
	func addSubviews() {
		addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(separatorView)
		stackView.addArrangedSubview(takePhotoButton)
		stackView.addArrangedSubview(choosePhotoButton)
		stackView.addArrangedSubview(deletePhotoButton)
	}
	
	func setupConstraints() {
		stackView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(32)
			make.leading.equalToSuperview().offset(16)
			make.trailing.equalToSuperview().offset(-16)
			make.bottom.equalToSuperview().offset(-20)
		}
		
		separatorView.snp.makeConstraints { make in
			make.height.equalTo(1)
		}
	}
}
