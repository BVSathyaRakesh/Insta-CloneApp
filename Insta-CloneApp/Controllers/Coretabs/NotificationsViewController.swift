//
//  NotificationsViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {
    
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
    
    private var models =  [UserNotification]()
    
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
        
        fetchNotifications()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = false
        view.addSubview(tableView)
        notificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        notificationsView.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
            let user = User(userName: "joe", name: (first: "", last: ""), birthDate: Date(), gender: .male, count: UserCount(followers: 1, following: 1, posts: 1), joinedDate: Date(), profilePhoto: URL(string: "https://www.google.com/")!)
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, captions: nil, likeCount: [], comments: [], Createddate: Date(), taggedUser: [],owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .like(post:post) : .follow(state: .not_following),
                                         text: "hello World",
                                         user:user)
            models.append(model)
        }
    }

}

extension NotificationsViewController : UITableViewDataSource,UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsLikeEventTableViewCell.identifier,for: indexPath) as! NotificationsLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier,for: indexPath) as! NotificationFollowEventTableViewCell
           // cell.configure(with: model)
            cell.delegate = self
            return cell
        }
               
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //data[indexPath.section][indexPath.row].handler()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}

extension NotificationsViewController : NotificationsLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        //open the post
        
        switch(model.type){
        case .like(let post) :
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(_):
            fatalError("Dev Issue: should never get called")
        }
        
       
        
    }
}

extension NotificationsViewController : NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped Button")
        //perform database update
    }
}
