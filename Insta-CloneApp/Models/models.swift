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
    let profilePhoto : URL
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum userPostType : String{
    case photo = "photo"
    case video = "audio"
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: userPostType
    let thumbnailImage : URL  //either video url or full resolution photo
    let captions: String?
    let likeCount: [PostLike]
    let comments: [Postcomment]
    let Createddate: Date
    let taggedUser: [String]
    let owner: User
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
    let identifier: String
    let userName : String
    let text: String
    let createdDate: Date
    let likes:[CommentLike]
}

