//
//  AlertManager.swift
//  PodcastApp
//
//  Created by Sergey on 27.09.2023.
//

import UIKit

protocol AlertControllerManagerProtocol: AnyObject {
    
    func showAlert(title: String, message: String) -> UIAlertController
    func showAlertQuestion(title: String, message: String, completionBlock: @escaping(Bool) -> Void) -> UIAlertController
    
}

class AlertControllerManager: AlertControllerManagerProtocol {
    
    //MARK: - Alert message
    
    func showAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        return alert
        
    }
    
    //MARK: - Alert question
    
    func showAlertQuestion(title: String, message: String, completionBlock: @escaping (Bool) -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completionBlock(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            completionBlock(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
        
    }
    
    
}

