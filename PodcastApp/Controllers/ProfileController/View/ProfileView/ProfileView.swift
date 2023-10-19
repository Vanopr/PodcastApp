//
//  ProfileView.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import Foundation
import UIKit
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    
    func profileView(didTapLogOutButton button: UIButton)
    
}

class ProfileView: CustomView {
    
    weak var delegateLogout: ProfileViewDelegate?
    
    private let userView = UserView()
    let buttonView = ButtonView()
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.lightBlue, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightBlue.cgColor
        button.layer.cornerRadius = 30.0
        return button
    }()
    
    override func setViews() {
        super.setViews()
        backgroundColor = .white
    }
    
    override func layoutViews() {
        super.layoutViews()
        addSubview(userView)
        addSubview(logOutButton)
        addSubview(buttonView)
        
        logOutButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(52)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-112)
            make.height.equalTo(60)
        }
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(54)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        
        delegateLogout?.profileView(didTapLogOutButton: button)
        
    }
    
}


