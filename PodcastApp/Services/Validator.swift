//
//  Validator.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/30/23.
//

import Foundation

class Validator {
    
    static func isValidEmail(for email: String) -> Bool {
        
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        guard let regex = try? NSRegularExpression(pattern: emailRegEx) else { return false }
        
        let nsRange = NSRange(location: 0, length: trimmedEmail.count)
        
        let results = regex.matches(in: trimmedEmail, range: nsRange)
        
        return  results.count == 0 ? false : true
    }
    
    static func isPasswordValid(for password : String) -> Bool {
        
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        
        return passwordPred.evaluate(with: password)
        
    }
    
}
