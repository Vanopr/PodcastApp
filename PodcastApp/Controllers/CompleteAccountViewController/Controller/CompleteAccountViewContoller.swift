//
//  CompleteAccountViewContoller.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/30/23.
//

import UIKit
import SnapKit
import FirebaseAuth

final class CompleteAccountViewContoller: UIViewController {
    
    //  MARK: - Variables
    
    private var originalFrame: CGRect?
    
    private var keyboardOffset: CGFloat = 0
    
    private let alertControllerManager = AlertControllerManager()
    
    var enteredEmail: String?
    
    //    MARK: - UI Elements
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ArrowBack"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        button.layer.cornerRadius = 24
        button.backgroundColor = .shadowGray
        return button
    }()

    
    private let titleLabel: UILabel = {
        let label = UILabel(labelText: "Complet your account", textColor: .black)
        label.textAlignment = .center
        label.font = .manropeBold(size: 24)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel(labelText: "Enter your Credentials", textColor: .black)
        label.textAlignment = .center
        label.font = .manropeExtraBold(size: 16)
        return label
    }()
    
    private let firstNameLabel: UILabel = {
        return UILabel(labelText: "First Name", textColor: .gray)
    }()
    
    private let firstNameTextField = {
        let textField = UITextField(placeHolder: "Enter your First Name", textColor: .gray, backGroundColor: .ghostWhite)
        return textField
    }()
    
    private let lastNameLabel: UILabel = {
        return UILabel(labelText: "Last Name", textColor: .gray)
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField(placeHolder: "Enter your Last Name", textColor: .gray, backGroundColor: .ghostWhite)
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        return UILabel(labelText: "Password", textColor: .gray)
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField(placeHolder: "Enter your password", textColor: .gray, backGroundColor: .ghostWhite)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordShowIndicator: UIImageView = {
        let passwordIndicator = UIImageView()
        passwordIndicator.image = UIImage(systemName: "eye.slash")
        passwordIndicator.tintColor = .gray
        passwordIndicator.isUserInteractionEnabled = true
        return passwordIndicator
    }()
    
    private let confirmPasswordLabel: UILabel = {
        return UILabel(labelText: "Confirm Password", textColor: .gray)
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField(placeHolder: "Confirm your password", textColor: .gray, backGroundColor: .ghostWhite)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let confirmPasswordShowIndicator: UIImageView = {
        let passwordIndicator = UIImageView()
        passwordIndicator.image = UIImage(systemName: "eye.slash")
        passwordIndicator.tintColor = .gray
        passwordIndicator.isUserInteractionEnabled = true
        return passwordIndicator
    }()
    
    private lazy var credentialsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, passwordLabel, passwordTextField, confirmPasswordLabel, confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(normalStateText: "Sign Up", normalStateTextColor: .white, backgroundColor: .skyBlue)
        button.layer.cornerRadius = 25.0
        button.addTarget(signupButtonPressed.self, action: #selector(signupButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var logInLabel: UILabel = {
        let label = UILabel()
        let text = "Already have an account? Login"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: text.count))
        let purpleRange = (text as NSString).range(of: "Login")
        attributedText.addAttribute(.foregroundColor, value: UIColor.lightPurple, range: purpleRange)
        label.attributedText = attributedText
        label.font = UIFont.systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    //    MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setUpView()
    }
    
}

extension CompleteAccountViewContoller {
    
    //    MARK: - Private Functions
    
    private func setUpView() {
        setNavigation()
        addSubViews()
        setConstrains()
        actionsToUI()
        setDelegates()
    }
    

    
    private func setNavigation() {
        title = "Sign Up"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(credentialsStackView)
        passwordTextField.addSubview(passwordShowIndicator)
        confirmPasswordTextField.addSubview(confirmPasswordShowIndicator)
        view.addSubview(signUpButton)
        view.addSubview(logInLabel)
    }
    
    private func setConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        credentialsStackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        for textField in credentialsStackView.arrangedSubviews.compactMap({ $0 as? UITextField }) {
            textField.snp.makeConstraints { make in
                make.height.equalTo(52)
            }
        }
        
        passwordShowIndicator.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(20)
            make.trailing.equalTo(passwordTextField).offset(-10)
            make.centerY.equalTo(passwordTextField)
        }
        
        confirmPasswordShowIndicator.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(20)
            make.trailing.equalTo(confirmPasswordTextField).offset(-10)
            make.centerY.equalTo(confirmPasswordTextField)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(credentialsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        logInLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-33)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    private func actionsToUI() {
        let gestureHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureHideKeyboard)
        
        let passwordShowIndicatorPressed = UITapGestureRecognizer(target: self, action: #selector(passwordShowIndicatorPressed))
        passwordShowIndicator.addGestureRecognizer(passwordShowIndicatorPressed)
        
        let confirmPasswordShowIndicatorTapGesture = UITapGestureRecognizer(target: self, action: #selector(confirmPasswordShowIndicatorPressed))
        confirmPasswordShowIndicator.addGestureRecognizer(confirmPasswordShowIndicatorTapGesture)
        
        logInLabel.isUserInteractionEnabled = true
        logInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logInLabelPressed)))
    }
    
    private func setDelegates() {
        
        for textField in credentialsStackView.arrangedSubviews.compactMap({ $0 as? UITextField }) {
            textField.delegate = self
        }
    }
    
    //  MARK: - Private objc func
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func passwordShowIndicatorPressed() {
        if passwordTextField.text != "" {
            passwordTextField.isSecureTextEntry.toggle()
            passwordShowIndicator.image = passwordTextField.isSecureTextEntry == true ?  UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        }
    }
    
    @objc private func confirmPasswordShowIndicatorPressed() {
        if confirmPasswordTextField.text != "" {
            confirmPasswordTextField.isSecureTextEntry.toggle()
            confirmPasswordShowIndicator.image = confirmPasswordTextField.isSecureTextEntry == true ?  UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        }
    }
    
    @objc private func signupButtonPressed() {
        
        guard let email = enteredEmail else { return }
        
        guard let firstName = firstNameTextField.text, !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let lastName = lastNameTextField.text, !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let password = passwordTextField.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        if !Validator.isPasswordValid(for: password) {
            let alert = alertControllerManager.showAlert(title: "Invalid Password", message: "Your Password must contain 1 upper case letter, 1 lower case letter, 1 Number, 1 special character.")
            present(alert, animated: true, completion: nil)
            return
        }
        
        if password == confirmPassword {
            let userRequest = UserRequest(firstName: firstName, lastName: lastName, email: email, password: password)
            
            AuthService.shared.registerUser(with: userRequest) { [weak self] wasRegistered, error in
                guard let self = self else { return }
                
                if let error = error {
                    let alert = self.alertControllerManager.showAlert(title: "Error", message: error.localizedDescription)
                    self.present(alert, animated: true)
                }
                
                if wasRegistered {
                    guard let _ = Auth.auth().currentUser else {
//                    Handle
                        return
                    }
                    
                    let alert = alertControllerManager.showAlertQuestion(title: "Вы успешно зарегистрировались!", message: "Теперь войдите в свой аккаунт.") { check in
                        self.logInLabelPressed()
                    }
                    present(alert, animated: true)
                }
                
            }
            
        } else {
            let alert = alertControllerManager.showAlert(title: "Passwords do not match", message: "Please enter password, then confirm it")
            present(alert, animated: true)
        }
        
    }
    
    @objc private func logInLabelPressed() {
        let fullScreenViewController = LoginInViewController()
        let navigationController = UINavigationController(rootViewController: fullScreenViewController)

        navigationController.navigationBar.tintColor = .blue

        if let targetWindowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let window = targetWindowScene.windows.first {
                let transition = CATransition()
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                window.rootViewController = navigationController
                window.layer.add(transition, forKey: nil)
            }
        }
    }
    
}

extension CompleteAccountViewContoller: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == passwordTextField || textField == confirmPasswordTextField {
            
            let offset: CGFloat = 100.0
            
            if originalFrame == nil {
                originalFrame = view.frame
            }
            
            view.frame = CGRect(x: view.frame.origin.x,
                                y: view.frame.origin.y - offset,
                                width: view.frame.size.width,
                                height: view.frame.size.height)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == passwordTextField || textField == confirmPasswordTextField {
            if let originalFrame = originalFrame {
                view.frame = originalFrame
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
