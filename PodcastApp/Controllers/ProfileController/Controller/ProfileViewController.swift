//
//  ProfileViewController.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: CustomViewController<ProfileView> {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let profView = ProfileView()
        customView.delegateLogout = self
        customView.buttonView.delegate = self
        
//        view = profView
    }
    
}

extension ProfileViewController: ButtonViewDelegate {
    func didSelectButton() {
        let vc = AccountSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: ProfileViewDelegate {
    
    func profileView(didTapLogOutButton button: UIButton) {
        
        if GIDSignIn.sharedInstance.currentUser != nil {
            GIDSignIn.sharedInstance.signOut()
        } else {
            do {
                try Auth.auth().signOut()
            } catch let error {
                print("Error. logOutButtonPress. already logged out: ", error.localizedDescription)
            }
        }
        
        defaults.set(nil, forKey: "onboardingWasShown")
        let onVC = OnboardingViewController()
        onVC.modalPresentationStyle = .fullScreen
        present(onVC, animated: true)
        
//        self.dismiss(animated: true)
    }
    
}

