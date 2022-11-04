//
//  RegistrationViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let userEmail: UITextField = {
        let field = UITextField()
        field.placeholder = "User Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "UserName..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 8.0
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
        field.layer.cornerRadius = 8.0
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemGreen
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self,
                              action: #selector(didTapRegister) ,
                              for: .touchUpInside)
        
        userEmail.delegate = self
        userNameField.delegate = self
        passwordField.delegate = self

        addSubviews()
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userEmail.frame = CGRect(x: 25,
                                 y: view.safeAreaInsets.top + 20,
                                      width: view.width-50,
                                      height: 52.0);
        
        userNameField.frame = CGRect(x: 25,
                                     y: userEmail.bottom + 20,
                                      width: view.width-50,
                                      height: 52.0);
        
        passwordField.frame = CGRect(x: 25,
                                     y: userNameField.bottom+10,
                                     width: view.width-50,
                                     height: 52.0);
        
        registerButton.frame = CGRect(x: 25,
                                   y: passwordField.bottom+10,
                                   width: view.width-50,
                                   height: 52.0);
    }
    
    func addSubviews(){
        view.addSubview(userEmail)
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    @objc func didTapRegister(){
        
        userEmail.resignFirstResponder()
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = userEmail.text, !email.isEmpty ,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let userName = userNameField.text, !userName.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(userName: userName, email: email, password: password) { registered in
            if(registered){
                
            }else{
                
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
