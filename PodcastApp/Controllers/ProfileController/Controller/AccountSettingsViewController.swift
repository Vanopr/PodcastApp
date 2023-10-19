//
//  AccountSettingsViewController.swift
//  PodcastApp
//
//  Created by VASILY IKONNIKOV on 27.09.2023.
//

import UIKit
import SnapKit

class AccountSettingsViewController: UIViewController {
    
    private let avatarView = AvatarView()
	private let profileInfo = ProfileInfo()
	private let scrollView = UIScrollView()
	
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(.santaGray, for: .normal)
        button.backgroundColor = .ghostWhite
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        addSubviews()
        setupConstraints()
        setupNavigationBarAppearance()
		avatarView.delegate = self
    }
    
    private func setupNavigationBarAppearance() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: "ArrowBackTo"),
            style: .plain,
            target: self,
            action: #selector(popToPrevious)
        )
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.manropeRegular(size: 18) ?? UIFont.systemFont(ofSize: 18)
        ]
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Profile"
    }
    
    @objc private func popToPrevious() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}

extension AccountSettingsViewController: AvatarViewDelegate {
	func editPhotoTap() {
		let popUpVC = PopUpViewController()
		popUpVC.modalPresentationStyle = .overCurrentContext
		popUpVC.modalTransitionStyle = .crossDissolve
		
		present(popUpVC, animated: true)
	}
}

// MARK: - Layout
extension AccountSettingsViewController {
    func addSubviews() {
        view.addSubview(avatarView)
        view.addSubview(saveButton)
		view.addSubview(scrollView)
		scrollView.addSubview(profileInfo)
    }
    
    func setupConstraints() {
        avatarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(37)
            make.height.equalTo(100)
            make.width.equalTo(105)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-34)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(avatarView.snp.bottom).offset(16)
			make.leading.equalToSuperview().offset(24)
			make.trailing.equalToSuperview().offset(-19)
			make.bottom.equalTo(saveButton.snp.top)
		}
		
		profileInfo.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.width.equalTo(scrollView.snp.width).offset(-5)
			make.height.equalTo(470)
		}
        
    }
}
