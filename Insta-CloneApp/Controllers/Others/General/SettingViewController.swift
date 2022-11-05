//
//  SettingViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import UIKit

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
        let section = [
            SettingsCellModel(title: "Logout") { [weak self] in
                self?.didTapLogout()
            }
        ]
        data.append(section)
    }
    
    private func didTapLogout(){
        
        let alert =  UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}
