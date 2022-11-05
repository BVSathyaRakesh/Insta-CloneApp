//
//  ProfileViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
   private func configureNavigationBar(){
       navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapSettings))
    }
    
    @objc func didTapSettings() {
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }

}
