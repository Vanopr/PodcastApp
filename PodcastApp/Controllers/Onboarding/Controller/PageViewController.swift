//
//  PageViewController.swift
//  PodcastApp
//
//  Created by Aleksandr Garipov on 27.09.2023.
//

import Foundation
import Firebase

class PageViewController: CustomViewController<PageView> {
    
    //MARK: - Properties
    
    private var pageType: PageViewType?
    
    
    //MARK: - Life Cycle
    
    init(pageType: PageViewType) {
        self.pageType = pageType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Methods
    
    private func setupView() {
        guard let pageView = self.view as? PageView else { return }
        pageView.delegate = self
        guard let pageType else { return }
        pageView.configureView(with: pageType)
    }
    
    private func setOnboardingShowKey() {
        UserDefaults.standard.set(true, forKey: "onboardingWasShown")
    }
}

extension PageViewController: PageViewDelegate {
    func skipButtonPressed() {
        setOnboardingShowKey()
        if Auth.auth().currentUser != nil {
            let customTabBarController = CustomTabBarController()
            customTabBarController.modalPresentationStyle = .fullScreen
            present(customTabBarController, animated: true)
        } else {
            let loginInViewController = LoginInViewController()
            loginInViewController.modalPresentationStyle = .fullScreen
            present(loginInViewController, animated: true)
        }
    }
    
    func nextButtonPressed() {
        print("nextButton pressed")
        guard let pageViewController = parent as? OnboardingViewController else { return }
        pageViewController.scrollNextViewController()
    }
}
