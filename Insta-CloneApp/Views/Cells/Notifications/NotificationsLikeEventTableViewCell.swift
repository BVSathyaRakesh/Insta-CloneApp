//
//  NotificationsLikeEventTableViewCell.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/12.
//

import UIKit

import SDWebImage

protocol NotificationsLikeEventTableViewCellDelegate : AnyObject {
    func didTapRelatedPostButton(model:UserNotification)
}

class NotificationsLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationsLikeEventTableViewCell"
    
    private var model: UserNotification?
    
    weak var delegate: NotificationsLikeEventTableViewCellDelegate?
    
    private let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.image = UIImage(named: "mountain")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private  let label: UILabel = {
        let label = UILabel()
        label.text = "@joe liked your Photo"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private  let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "mountain"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    @objc func didTapPostsButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification){
        self.model =  model
        switch self.model?.type  {
        case .like(let post):
            let thumbNail = post.thumbnailImage
            guard !thumbNail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbNail, for: .normal)
        case .follow:
            break
        case .none:
            break
        }
        
        label.text = model.text
        photoImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        photoImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //photo,text, post button
        photoImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        photoImageView.layer.cornerRadius = photoImageView.height/2
        
        let size = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-photoImageView.width-(size)/2.0+4,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: photoImageView.right + 5,
                             y: 0,
                             width: contentView.width-size-photoImageView.width-16,
                             height: contentView.height)
    }
    
}

