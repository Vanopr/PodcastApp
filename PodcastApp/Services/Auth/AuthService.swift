//
//  AuthService.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 10/2/23.
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
    
    /// A method to Sign Out User
    /// - Parameter completion:
    /// ///    - Error? : An optinoal Error if Data Base provides one
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    /// A method to get current User
    ///    -  UesrRequest?: result - returns model of user
    ///    - Error? : An optinoal Error if Data Base provides one
    public func getCurrentUser(completion: @escaping (Error?, UserRequest?) -> Void) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let db = Firestore.firestore()
            
            db.collection("user")
                .document(uid)
                .getDocument { (document, error) in
                    if let error = error {
                        completion(error, nil)
                        return
                    }
                    
                    if let document = document, document.exists {
                        let data = document.data()
                        
                        if let firstName = data?["firstName"] as? String,
                           let lastName = data?["lastName"] as? String {
                            
                            let userRequest = UserRequest(firstName: firstName, lastName: lastName, email: user.email ?? "", password: "")
                            completion(nil, userRequest)
                        } else {
                            // Missing required data
                            completion(NSError(domain: "PodcastApp", code: 400, userInfo: [NSLocalizedDescriptionKey: "User data is incomplete"]), nil)
                        }
                    } else {
                        // Document does not exist
                        completion(NSError(domain: "PodcastApp", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]), nil)
                    }
                }
        } else {
            let error = NSError(domain: "PodcastApp", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not signed in"])
            completion(error, nil)
        }
    }
    
    /// A method to signInUser
    /// - Parameters:
    ///   - userRequest: The user info (UserName, Email, Password)
    ///   - comletion:  A comletion with two values :
    ///    -  Bool: result - Determines DB has this user or not and if Has its Sign In
    ///    - Error? : An optinoal Error if Data Base provides one
    public func storeUserDataInFirestore(user: UserRequest) {
        let db = Firestore.firestore()
        
        let userRef = db.collection("user").document(user.email)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error retrieving user data: \(error.localizedDescription)")
            } else if document?.exists != true {
                userRef.setData([
                    "firstName": user.firstName ?? "",
                    "lastName": user.lastName ?? "",
                    "email": user.email,
                ]) { error in
                    if let error = error {
                        print("Error storing user data: \(error.localizedDescription)")
                    } else {
                        print("User data stored successfully.")
                    }
                }
            }
        }
    }
    
}
