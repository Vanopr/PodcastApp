//
//  PopUpViewController.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 02.10.2023.
//

import UIKit
import SnapKit

class PopUpViewController: UIViewController {
	
	private let popUpView = PopUpView()
	private let blurView = UIVisualEffectView()

    override func viewDidLoad() {
        super.viewDidLoad()
		addSubviews()
		setupConstraints()
		setupBlur()
		setupTapGesture()
    }
	
	private func setupBlur() {
		let blurEffect = UIBlurEffect(style: .light)
		blurView.effect = blurEffect
		blurView.backgroundColor = UIColor.popColor
	}
	
	private func setupTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
		view.addGestureRecognizer(tapGesture)
	}
	
	@objc private func handleTap(_ gesture: UITapGestureRecognizer) {
		dismiss(animated: true, completion: nil)
	}
}

// MARK: - Layout
private extension PopUpViewController {
	func addSubviews() {
		view.addSubview(blurView)
		view.addSubview(popUpView)
	}
	
	func setupConstraints() {
		
		blurView.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		popUpView.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(180)
			make.leading.equalToSuperview().offset(24)
			make.trailing.equalToSuperview().offset(-24)
			make.height.equalTo(340)
		}
	}
}
