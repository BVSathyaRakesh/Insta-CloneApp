//
//  models.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/7.
//

import Foundation

public enum Gender {
    case male, female,other
}

struct User {
    let userName : String
    let name:(first:String,last:String)
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinedDate : Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum userPostType {
    case photo, video
}

/// Represents a user post
public struct PhotoPost {
    let identifier: String
    let postType: userPostType
    let thumbnailImage : URL  //either video url or full resolution photo
    let captions: String?
    let likeCount: [PostLike]
    let comments: [Postcomment]
    let Createddate: Date
    let taggedUser: [String]
}


struct PostLike {
    let userName: String
    let postIdentifier : String
    
}

struct CommentLike {
    let userName:String
    let commentIdentifier:String
}

struct Postcomment {
    let userName : String
    let text: String
    let createdDate: Date
    let likes:[CommentLike]
}

