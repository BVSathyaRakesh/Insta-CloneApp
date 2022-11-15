//
//  UserFollowTableViewCell.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/12.
//

import UIKit

protocol UserFollowTableViewCellDelegate : AnyObject {
    func didTapFollowUnfollowButton(model:UserRelationShip)
}

enum FollowState {
    case following //indicates the current user is following the other user
    case not_following //indicates the current user is NOT following the other user
}

struct UserRelationShip {
    let userName: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

   static let identifier = "userFollowTableViewcell"
    
    private var model: UserRelationShip?
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "joe"
      
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@joe"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(disTapFollowButton), for: .touchUpInside)
    }
    
    @objc func disTapFollowButton() {
        
        guard let model = self.model else {
            return
        }
        
        self.delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        userNameLabel.text = nil
        profileImageView.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-6,
                                        height: contentView.height-6)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: (contentView.height-40)/2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right+5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                 height: labelHeight)
        
        userNameLabel.frame = CGRect(x: profileImageView.right+5,
                                     y: nameLabel.bottom,
                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                 height: labelHeight)
    }
    
    public func configure(with model:UserRelationShip) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.userName
        switch model.type {
        case .following:
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
}
