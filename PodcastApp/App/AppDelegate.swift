//
//  AppDelegate.swift
//  PodcastApp
//
//  Created by Sergey on 25.09.2023.
//

import UIKit
import PodcastIndexKit
import RealmSwift
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let realm = try! Realm()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        loadDataFromRealm()
        
        PodcastIndexKit.setup(apiKey: "D45ZGFQ26LEQC7D4D5PW", apiSecret: "ECjvzUTaqq3QK7LRA^RjWgbmmCfCcK9q#9pKAA53", userAgent: "MyiOSApp/1.0 (iPhone; iOS 15.0; Scale/2.0)")

        FirebaseApp.configure()
        return true
    }

    
    //  MARK:
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }
    

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveDataToRealm()
    }
    
    private func saveDataToRealm() {
        let idArray = LikedPodcast.shared.likedPodcasts
        let intArrayObject = LikedIdArray(idArray: idArray)
        let objectsToDelete = realm.objects(LikedIdArray.self)
        try! realm.write {
            realm.delete(objectsToDelete)
            realm.add(intArrayObject)
        }
    }
    
    private func loadDataFromRealm() {
        if let intArrayObject = realm.objects(LikedIdArray.self).last {
            LikedPodcast.shared.likedPodcasts = Array(intArrayObject.idArray)
        }
    }
    
    
}

