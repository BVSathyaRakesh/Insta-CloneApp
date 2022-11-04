//
//  DataBaseManager.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import FirebaseDatabase
import Foundation

public class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
    //Mark: -Public
    
        /// Check if userName and email is available
        ///  - Parameters
        ///   -email: String representing email
        ///   -userName:String representing userName
    
    public func canCreateNewuser(with email:String, userName:String, completion: @escaping(Bool) -> Void) {
        completion(true)
    }
    
    /// Check if userName and email is available
    ///  - Parameters
    ///   -email: String representing email
    ///   -userName:String representing userName
    ///   -completion:Async callback for result if database entry succeded
    public func insertNewUser(with email:String, userName:String, completion: @escaping (Bool)-> Void) {
        
        database.child(email.safeDatabase()).setValue(["userName":userName]) { error, _ in
            if error == nil {
                completion(true)
                return
            }else{
                completion(false)
                return
            }
        }
    }
    
    //Mark:Private
 
}
