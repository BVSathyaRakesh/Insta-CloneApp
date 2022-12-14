//
//  HomeViewController.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/1.
//

import FirebaseAuth
import UIKit

struct HomeFeedHeaderViewModel {
    let header: PostRenderViewModel
    let post : PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderViewModels = [HomeFeedHeaderViewModel]()
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        ///Register Cells
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
       return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        createMockModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
    
    private func createMockModels(){
        
        let user = User(userName: "joe",
                        name: (first: "", last: ""),
                        birthDate: Date(),
                        gender: .male,
                        count: UserCount(followers: 1, following: 1, posts: 1),
                        joinedDate: Date(),
                        profilePhoto: URL(string: "https://www.google.com/")!)
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            captions: nil,
                            likeCount: [],
                            comments: [],
                            Createddate: Date(),
                            taggedUser: [],owner: user)
        
        var comments = [Postcomment]()
        
        for x in 0..<2 {
            comments.append(Postcomment(identifier: "\(x)", userName: "@jenny", text: "This is best post I've seen", createdDate: Date(), likes: []))
        }
        
        for x in 0..<5 {
            let viewModel = HomeFeedHeaderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderViewModels.append(viewModel)
        }
    }
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderViewModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedHeaderViewModel
        
        if x == 0 {
             model = feedRenderViewModels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x-(x-4))/4)
            model = feedRenderViewModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            return 1
        }
        
        if subSection == 1 {
            //post
            return 1
        }
        
        if subSection == 2 {
            //actions
            return 1
        }
        
        if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
               case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            @unknown default : fatalError("Invalid case")
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedHeaderViewModel
        
        if x == 0 {
             model = feedRenderViewModels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x-(x-4))/4)
            model = feedRenderViewModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            //header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let header):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                
                return cell
            case .primaryContent,.actions,.comments: return UITableViewCell()
            }
        }
        
        if subSection == 1 {
            //post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                
                return cell
            case .header,.actions,.comments: return UITableViewCell()
            }
            
        }
        
        if subSection == 2 {
            //actions
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let action):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
                
                return cell
            case .header,.primaryContent,.comments: return UITableViewCell()
            }
        }
        
        if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                
                return cell
              case .header,.primaryContent,.actions: return UITableViewCell()
            }
        }
        
        
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subsection = indexPath.section % 4
        
        if subsection == 0 {
            return 70
        }
        else if subsection == 1 {
            return tableView.width
        }
        
        else if subsection == 2 {
            return 60
        }
        
        else if subsection == 3 {
            return 50
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let subsection = section % 4
        
        return subsection == 3 ? 70 : 0
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
