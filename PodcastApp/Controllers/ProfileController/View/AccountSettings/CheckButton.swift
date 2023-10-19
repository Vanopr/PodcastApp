//
//  CheckButton.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 02.10.2023.
//

import UIKit

class CheckButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCheckbox()
	}
	
	convenience init(title: String) {
		self.init()
		configuration(with: title)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupCheckbox() {
		setImage(UIImage(named: "uncheck"), for: .normal)
		setImage(UIImage(named: "check"), for: .selected)
	}
	
	private func configuration(with title: String) {
		configuration = .filled()
		configuration?.title = title
		
		var container = AttributeContainer()
		container.font = UIFont.manropeRegular(size: 16)
		
		configuration?.attributedTitle = AttributedString(title, attributes: container)
		
		configuration?.baseBackgroundColor = .white
		configuration?.baseForegroundColor = UIColor.black
		configuration?.imagePlacement = .leading
		configuration?.contentInsets.leading = 16
		configuration?.imagePadding = 16
		contentHorizontalAlignment = .leading
		
		layer.borderWidth = 1.0
		layer.borderColor = UIColor.lightBlue.cgColor
		layer.cornerRadius = 24
		
	}
}
