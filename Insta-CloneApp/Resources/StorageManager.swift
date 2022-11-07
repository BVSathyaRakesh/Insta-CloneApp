//
//  StorageManager.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//
import FirebaseStorage
import Foundation

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public  enum IGStorageManagerError: Error {
        case failedDownload
    }
    
    public func uploadUserPost(model: PhotoPost, completion: @escaping(Result<URL,Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL,IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            completion(.failure(.failedDownload))
            return
        }
    }

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
}
struct PostLike {
    let userName: String
    let postIdentifier : String
    
}

struct 

struct Postcomment {
    let userName : String
    let text: String
    let createdDate: Date
    let likes:
}
