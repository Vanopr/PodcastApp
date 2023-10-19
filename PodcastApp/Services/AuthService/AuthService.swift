//
//  AuthService.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/30/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


final class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    
    ///  A method to register user
    /// - Parameters:
    ///   - userRequest: The user info (UserName, Email, Password)
    ///   - comletion:  A comletion with two values :
    ///    -  Bool: wasRegistered - Determines the user was registered and saved to the Data Base correctly
    ///    - Error? : An optinoal Error if Data Base provides one
    
    public func registerUser(with userRequest: UserRequest, completion: @escaping (Bool, Error?) -> Void) {
        
        guard let firstName = userRequest.firstName else { return }
        guard let lastName = userRequest.lastName else { return }
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                
                completion(false, error)
                
                return
            }
            
            //            Getting Signed Up User
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("user")
                .document(resultUser.uid)
                .setData([
                    
                    "fistName" : firstName  ,
                    "lastName" : lastName ,
                    "email" : email,
                    "userID" : resultUser.uid
                    
                ]) { error in
                    if let error = error {
                        
                        completion(false, error)
                        
                        return
                    }
                    
                    completion(true, nil)
                }
            
        }
        
    }
    
    /// A method to signInUser
        /// - Parameters:
        ///   - userRequest: The user info (UserName, Email, Password)
        ///   - comletion:  A comletion with two values :
        ///    -  Bool: result - Determines DB has this user or not and if Has its Sign In
        ///    - Error? : An optinoal Error if Data Base provides one
        public func signInRequest(with userRequest: UserRequest, completion: @escaping (Bool, Error?) -> Void) {
            
            let userEmail = userRequest.email
            let userPassword = userRequest.password
            
            Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
                
                if let error = error {
                    
                    completion(false, error)
                    
                    return
                } else {
                    completion(true, nil)
                }
                
                
                
            }
            
            
        }
}
