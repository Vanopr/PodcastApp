//
//  PopUpButton.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 02.10.2023.
//

import UIKit

class PopUpButton: UIButton {
	
	convenience init(title: String, imageName: String) {
		self.init()
		configuration(with: title, imageName: imageName)
	}
	
	private func configuration(with title: String, imageName: String) {
		configuration = .filled()
		configuration?.title = title
		
		var container = AttributeContainer()
		container.font = UIFont.manropeRegular(size: 16)
		
		configuration?.attributedTitle = AttributedString(title, attributes: container)
		
		configuration?.image = UIImage(named: imageName)
		
		configuration?.baseBackgroundColor = .whiteSmoke
		configuration?.baseForegroundColor = UIColor.black
		configuration?.background.cornerRadius = 8
		configuration?.imagePlacement = .leading
		configuration?.imagePadding = 16
		contentHorizontalAlignment = .left
		configuration?.contentInsets.leading = 16
		configuration?.contentInsets.trailing = 16
	}
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: 60)
	}
}
