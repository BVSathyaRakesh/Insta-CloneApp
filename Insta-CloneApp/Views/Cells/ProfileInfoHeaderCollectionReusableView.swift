//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/7.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate :AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate : ProfileInfoHeaderCollectionReusableViewDelegate?

    
    private let profilePhotoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.setTitle("following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersButton : UIButton = {
        let button = UIButton()
        button.setTitle("followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Sathya Rakesh"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "This is the First Account"
        label.textColor = .label
        label.numberOfLines = 0 //line wrap
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func addSubViews(){
        addSubview(profilePhotoImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3.0
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postsButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5 + buttonHeight,
                                   width: countButtonWidth * 3,
                                   height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 5,
                                   y: 5 + profilePhotoImageView.bottom,
                                   width: width-10,
                                   height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(x: 5,
                                   y: 5 + nameLabel.bottom,
                                   width: width-10,
                                height: bioLabelSize.height).integral
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        
        editProfileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchUpInside)
    }
    
    //Mark: Actions
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidFollowingButton(self)

    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapProfileButton() {
        delegate?.profileHeaderDidEditProfileButton(self)
    }
    
}
