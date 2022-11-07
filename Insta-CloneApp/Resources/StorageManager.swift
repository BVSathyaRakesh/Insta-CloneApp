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


