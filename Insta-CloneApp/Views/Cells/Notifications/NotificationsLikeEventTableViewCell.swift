//
//  NotificationsLikeEventTableViewCell.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/12.
//

import UIKit

import UIKit

protocol NotificationsLikeEventTableViewCellDelegate : AnyObject {
    func didTapRelatedPostButton(model:String)
}

class NotificationsLikeEventTableViewCell: UITableViewCell {

  static let identifier = "NotificationsLikeEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private  let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private  let postButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: String){
     
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        photoImageView.image = nil
    }
    
    
}

