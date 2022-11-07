//
//  IGFeedPostGeneralTableViewCell.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/6.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostGeneralTableViewCell"

     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     public func configure() {
         // configure the cell
     }

}
