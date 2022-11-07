//
//  SettingViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import UIKit
import SafariServices

struct SettingsCellModel {
    let title : String
    let handler: (() -> Void)
}

class SettingViewController: UIViewController {
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       return tableView
    }()
    
    private var data = [[SettingsCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        configureModel()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        
    }
    
    private func configureModel(){
        
        data.append([
            SettingsCellModel(title: "Edit profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingsCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            },
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of Service") { [weak self] in
                self?.openUrl(type: .terms)
            },
            SettingsCellModel(title: "Privacy Policy") { [weak self] in
                self?.openUrl(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feedback") { [weak self] in
                self?.openUrl(type: .help)
            },
        ])
        
        data.append([
            SettingsCellModel(title: "Logout") { [weak self] in
                self?.didTapLogout()
            }
        ])
        
    }
    
    
  
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    
    private func didTapInviteFriends(){
        //Show Share Sheets to Invite Friends
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    private func openUrl (type:SettingsURLType){
        
        let urlString: String
        
        switch  type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/155833707900388"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc =  SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
  
    enum SettingsURLType {
        case terms,privacy,help
    }
    
    private func didTapLogout(){
        
        let alert =  UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            AuthManager.shared.logout { success in
                if success {
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                }
                else{
                    //error
                }
            }
        }))
        
        self.popoverPresentationController?.sourceView = tableView
        self.popoverPresentationController?.sourceRect = tableView.bounds
        self.present(alert, animated: false)
             
    }
}

extension SettingViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
