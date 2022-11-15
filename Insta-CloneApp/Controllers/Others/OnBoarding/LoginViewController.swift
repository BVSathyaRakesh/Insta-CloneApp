//
//  LoginViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("New user? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "InstaGradient"))
        header.addSubview(backgroundImageView)
        return header
    }()

    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms & Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton) ,
                              for: .touchUpInside)
        
        registerButton.addTarget(self,
                              action: #selector(didTapRegisterButton) ,
                              for: .touchUpInside)
        
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton) ,
                              for: .touchUpInside)
        
        privacyButton.addTarget(self,
                              action: #selector(didTapPrivacyButton) ,
                              for: .touchUpInside)
        
        userEmailField.delegate = self
        passwordField.delegate = self
        
        self.view.backgroundColor = .systemBackground
        addSubviews()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.height / 3.0);
        
        userEmailField.frame = CGRect(x: 25,
                                      y: headerView.bottom+30,
                                      width: view.width-50,
                                      height: 52.0);
        
        passwordField.frame = CGRect(x: 25,
                                     y: userEmailField.bottom+10,
                                     width: view.width-50,
                                     height: 52.0);
        
        loginButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom+10,
                                   width: view.width-50,
                                   height: 52.0);
        registerButton.frame = CGRect(x: 25,
                                   y: loginButton.bottom+10,
                                   width: view.width-50,
                                   height: 52.0);
        
        termsButton.frame = CGRect(x: 10,
                                   y:  view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width-50,
                                   height: 52.0);
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                   width: view.width-50,
                                   height: 52.0);
        
        configureHeaderView()
    }
    
    func addSubviews(){
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }
    
    func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        
        //Add Instagram Logo
        let imageView = UIImageView(image: UIImage(named: "InstaLogo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.frame.width / 2.0,
                                 height: headerView.frame.height - view.safeAreaInsets.top)
        
        
    }
    
    @objc  func didTapLoginButton(){
        
        userEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let usernameEmail = userEmailField.text , !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        //Login Functionality
        var email: String?
        var userName: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
        }else{
            userName = usernameEmail
        }
        
        AuthManager().loginUser(userName: userName, email: email, password: password) { status in
            DispatchQueue.main.async {
                if status == true{
                    self.dismiss(animated: true)
                }
                else{
                    let alert =  UIAlertController(title: "Login error...", message: "We are unable to log you in..", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    self.present(alert, animated: false)
                }
            }
        }
        
    }
    @objc  func didTapRegisterButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    @objc  func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/116024195217477") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc  func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
    
}
