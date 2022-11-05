//
//  Authmanager.swift
//  Insta-CloneApp
//
//  Created by Rakesh BVS. Kumar on 2022/11/2.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(userName:String, email:String, password:String, completion: @escaping (Bool) -> Void){
        
        /*
         - Check if userName is available
         - Check if email is available
         - Create Account
         - Insert Account to databse
         */
                
        DataBaseManager.shared.canCreateNewuser(with: email, userName: userName) { canCreate in
            if canCreate {
                 /*
                   - Create Account
                   - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil , result != nil else {
                        //Firebase auth could not create account
                        completion(false)
                        return
                    }
                    //Insert into database
                    DataBaseManager.shared.insertNewUser(with: email, userName: userName) { inserted in
                        if inserted {
                            //succeded in database
                            completion(true)
                            return
                        }else{
                            //failed into database
                            completion(false)
                            return
                        }
                    }
                }
            }else {
                completion(false)
            }
        }
        
        
    }
    
    public func loginUser(userName:String?, email:String?, password:String, completionHandler: @escaping(Bool) -> Void){
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard  authResult != nil , error == nil else {
                    completionHandler(false)
                    return
                }
                completionHandler(true)
            }
        }
        else if let userName = userName {
            print(userName)
        }
    }
    
    
    /// /Attempt to logout Firebase user
    public func logout(completion:(Bool)-> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}
