//
//  SignVC.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import UIKit
import FirebaseAuth
//import Firebase

final class SignUpVC: UIViewController {
    
    //MARK: - Create UI
    private lazy var topStackView = UIStackView.stackView
    private lazy var middleStackView = UIStackView.stackView
    private lazy var lowStackView = UIStackView.stackView
    private lazy var loginStackView = UIStackView.stackView
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "eye.slash"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordToggled), for: .touchUpInside)
        return button
    }()
    private lazy var showConfigPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "eye.slash"), for: .normal)
        button.addTarget(self, action: #selector(showConfigPasswordToggled), for: .touchUpInside)
        return button
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(named: "BlueButtonColor")
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var signLabel = UILabel.signTopLabel
    private lazy var firstNameLabel = UILabel.signLowLabel
    private lazy var lastNameLabel = UILabel.signLowLabel
    private lazy var emailLabel = UILabel.signLowLabel
    private lazy var passwordLabel = UILabel.signLowLabel
    private lazy var confPasswordLabel = UILabel.signLowLabel
    private lazy var topCompleteLabel = UILabel.signBigLabel
    private lazy var topLowLabel = UILabel.signLowLabel
    private lazy var hintLoginLabel = UILabel.hintLabel
    private lazy var loginLabel: UILabel = {
        let loginLabel = UILabel.hintLabel
        loginLabel.text = "Login"
        loginLabel.textColor = .systemBlue
        // Добавление действие для label
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(loginTapGesture)
        
        return loginLabel
    }()
    
    private var firstNameTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "LightBlueTextField")
        textField.placeholder = "Enter your first name" // задаем подсказку для текстового поля
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "BorderTextFieldColor")?.cgColor
        textField.layer.cornerRadius = 20
        return textField
    }()
    private var lastNameTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "LightBlueTextField")
        textField.placeholder = "Enter your last name" // задаем подсказку для текстового поля
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "BorderTextFieldColor")?.cgColor
        textField.layer.cornerRadius = 20
        return textField
    }()
    var emailTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "LightBlueTextField")
        textField.placeholder = "Enter your email address" // задаем подсказку для текстового поля
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "BorderTextFieldColor")?.cgColor
        textField.layer.cornerRadius = 20
        return textField
    }()
    private var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "LightBlueTextField")
        textField.placeholder = "Enter your password" // задаем подсказку для текстового поля
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "BorderTextFieldColor")?.cgColor
        textField.layer.cornerRadius = 20
        //        textField.isSecureTextEntry = false
        
        return textField
    }()
    private var confPasswordTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "LightBlueTextField")
        textField.placeholder = "Confirm your password" // задаем подсказку для текстового поля
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "BorderTextFieldColor")?.cgColor
        textField.layer.cornerRadius = 20
        //        textField.isSecureTextEntry = false
        return textField
        
    }()
    
    @objc private func signUpButtonPressed() {
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPasswoed = confPasswordTextField.text ?? ""
        
        if password != confirmPasswoed {
            showAlert(title: "Не совпадает", message: "Введите корректно")
        }
        else if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPasswoed.isEmpty {
            showAlert(title: "Нет данных", message: "Заполните все поля")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if error != nil {
                    strongSelf.showAlert(title: "Ошибка", message: error?.localizedDescription ?? "Введите данные заново")
                } else {
                    let set = ModelAuth(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPasswoed, isfirst: true)
                    UserDefManager.share.saveSettings(model: set)
                    
                    strongSelf.firstNameTextField.text = ""
                    strongSelf.lastNameTextField.text = ""
                    strongSelf.emailTextField.text = ""
                    strongSelf.passwordTextField.text = ""
                    strongSelf.confPasswordTextField.text = ""
                    
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    strongSelf.present(vc, animated: true)
                }
            }
        }
    }
    @objc private func backButtonPressed() {
        print("backButtonPressed")
    }
    
    @objc private func showPasswordToggled(sender:UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.setBackgroundImage(passwordTextField.isSecureTextEntry ? UIImage(named: "eye") : UIImage(named: "eye.slash"), for: .normal)
    }
    
    @objc private func showConfigPasswordToggled(sender:UIButton) {
        confPasswordTextField.isSecureTextEntry.toggle()
        sender.setBackgroundImage(confPasswordTextField.isSecureTextEntry ? UIImage(named: "eye") : UIImage(named: "eye.slash"), for: .normal)
    }
    
    @objc private func loginTapped() {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        config()
        setContraints()
    }
    
    private func setupViews() {
        topStackView.getArrangeViews(viewsToAdd: [signLabel,topCompleteLabel,topLowLabel])
        middleStackView.getArrangeViews(viewsToAdd: [firstNameLabel,firstNameTextField,
                                                     lastNameLabel,lastNameTextField,
                                                     emailLabel,emailTextField,
                                                     passwordLabel, passwordTextField,
                                                     confPasswordLabel, confPasswordTextField])
        loginStackView.getArrangeViews(viewsToAdd: [hintLoginLabel, loginLabel])
        lowStackView.getArrangeViews(viewsToAdd: [signUpButton])
        
        view.addSubview(topStackView)
        view.addSubview(middleStackView)
        view.addSubview(signUpButton)
        view.addSubview(loginStackView)
    }
    
    private func config() {
        topStackView.alignment = .center
        topStackView.spacing = 15
        loginStackView.axis = .horizontal
//        loginStackView.alignment = .fill
        loginStackView.distribution = .equalCentering
        view.backgroundColor = UIColor(named: "BackgroundColor")
        topCompleteLabel.text = "Complet your account"
        topLowLabel.text = "Lorem ipsum dolor sit amet"
        firstNameLabel.text = "First Name"
        signLabel.text = "Sign In"
        lastNameLabel.text = "Last Name"
        emailLabel.text = "E-mail"
        passwordLabel.text = "Password"
        confPasswordLabel.text = "Confirm Password"
        hintLoginLabel.text = "Already have an account?"
        
        //устанавливаем левое view для TF
        firstNameTextField.setLeftPaddingView(padding: 10)
        lastNameTextField.setLeftPaddingView(padding: 10)
        emailTextField.setLeftPaddingView(padding: 10)
        passwordTextField.setLeftPaddingView(padding: 10)
        confPasswordTextField.setLeftPaddingView(padding: 10)
        
        //устанавливаем правое view для TF
        passwordTextField.setRightPaddingView(button: showPasswordButton)
        confPasswordTextField.setRightPaddingView(button: showConfigPasswordButton)
    }
    
    private func setContraints () {
        NSLayoutConstraint.activate([
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topStackView.heightAnchor.constraint(equalToConstant: 100),
            
            middleStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            middleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            middleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            middleStackView.heightAnchor.constraint(equalToConstant: 450),
            
            signUpButton.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 80),
            
            loginStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 0),
            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            loginStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
        ])
    }
}
