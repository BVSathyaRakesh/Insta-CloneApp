//
//  NotificationsViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
        tableView.register(NotificationsLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationsLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
       return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var notificationsView = NoNotificationsView()
    
    //Mark: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
       // view.addSubview(spinner)
        spinner.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        notificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        notificationsView.center = view.center
    }

}

extension NotificationsViewController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsLikeEventTableViewCell.identifier,for: indexPath) as! NotificationsLikeEventTableViewCell
        //cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //data[indexPath.section][indexPath.row].handler()
    }
    
}
