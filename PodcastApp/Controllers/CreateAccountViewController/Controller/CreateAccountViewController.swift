//
//  CreateAccountViewController.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/29/23.
//

import UIKit
import SnapKit

final class CreateAccountViewController: UIViewController {
    
    //  MARK: - Variables
    
    private let alertControllerManager = AlertControllerManager()
    
    //    MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel(labelText: "Create account", textColor: .white)
        label.textAlignment = .center
        label.font = .manropeBold(size: 24)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel(labelText: "Podcast App", textColor: .white)
        label.textAlignment = .center
        label.font = .manropeExtraBold(size: 16)
        return label
    }()
    
    private let createAccountView: CreateAccountView = {
        let view = CreateAccountView()
        return view
    }()
    
    //    MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .skyBlue
        createAccountView.delegate = self
        navigationItem.hidesBackButton = true
        setUpView()
    }
    
}

extension CreateAccountViewController {
    
    //  MARK: - Private Functions
    
    private func setUpView() {
        addSubViews()
        setConstrains()
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(createAccountView)
    }
    
    private func setConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        createAccountView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(60)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //  MARK: - @objc private func
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension CreateAccountViewController: CreateAccountViewDelegate {
    
    func continueWithEmailButtonPressed(email: String) {
        let destinationVC = CompleteAccountViewContoller()
        destinationVC.enteredEmail = email
        
        if let navigationController = navigationController {
            navigationController.pushViewController(destinationVC, animated: true)
        } else {
            print("Navigation controller is nil. Make sure CreateAccountViewController is embedded in a UINavigationController.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = alertControllerManager.showAlert(title: title, message: message)
        present(alert, animated: true)
    }
    
}
