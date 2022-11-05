//
//  HomeViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil {
            //Show login
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }

}
