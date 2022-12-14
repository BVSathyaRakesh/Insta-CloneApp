//
//  NotificationFollowEventTableViewCell.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/12.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnFollowButton(model:UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

   static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?

    
    private let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private  let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "@kanyawest followed you"
        label.numberOfLines = 0
        return label
    }()
    
    private  let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
    }
    
    @objc func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification){
        self.model =  model
        switch self.model?.type  {
        case .like(_):
            break
        case .follow(let state):
            //configure button
            switch(state) {
            case .following:
                //show unfollow button
                configureForFollow()
                break
            case .not_following:
                //show following button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
                break
            }
            break
        case .none:
            break
        }
        
        label.text = model.text
        photoImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    private func configureForFollow(){
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        photoImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photo,text, post button
        photoImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        photoImageView.layer.cornerRadius = photoImageView.height/2
        
        let size :CGFloat = 100
        let buttonHeight :CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-5-size,
                                    y: (contentView.height-buttonHeight)/2,
                                  width: size,
                                  height: buttonHeight)
                
        label.frame = CGRect(x: photoImageView.right + 5,
                             y: 0,
                             width: contentView.width-size-photoImageView.width-16,
                             height: contentView.height)
    }
    
    
}
