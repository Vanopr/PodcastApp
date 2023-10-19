//
//  ValidationManager.swift
//  PodcastApp
//
//  Created by Sergey on 27.09.2023.
//

import Foundation

enum StringType {
    case email
    case password
    case userName
    case passwordMatch
    case emptyString
}

enum ValidateInputError: Error {
    case wrongSymbolsEmail
    case emptyString
    case passwordIncorrect
    case passwordNotMatch
    case userNameError
    case authError
    case findNil
    case notRegisterUser
}

extension ValidateInputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongSymbolsEmail:
            return NSLocalizedString("Вы использовали некорректный адрес e-mail!", comment: "Description of invalid e-mail address")
        case .emptyString:
            return NSLocalizedString("Все поля должны быть заполнены!", comment: "Description of empty string")
        case .passwordIncorrect:
            return NSLocalizedString("Вы использовали неверные символы в поле \"пароль\"!", comment: "Description of incorrect password")
        case .passwordNotMatch:
            return NSLocalizedString("Пароли не совпадают!", comment: "Description of not matching passwords")
        case .userNameError:
            return NSLocalizedString("Ошибка в имени пользователя!", comment: "Description of invalid user name")
        case .authError:
            return NSLocalizedString("Неправильное имя пользователя или пароль!", comment: "Authentication error")
        case .findNil:
            return NSLocalizedString("Can`t find in data base!", comment: "Return value is empty!")
        case .notRegisterUser:
            return NSLocalizedString("Вы не выполнили вход!", comment: "Пожалуйста зарегистрируйтесь или войдите!")
        }
    }
}

protocol ValidatorInputProtocol: AnyObject {
    func checkString(stringType: StringType, string: String, stringForMatching: String?) throws -> Bool
}

class ValidatorClass: ValidatorInputProtocol {
    
    func checkString(stringType: StringType, string: String, stringForMatching: String?) throws -> Bool {
        switch stringType {
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            let emailResult: Bool = emailPred.evaluate(with: string)
            if !emailResult {
                throw ValidateInputError.wrongSymbolsEmail
            }
        case .password:
            let passwordRegEx = "[A-Z0-9a-z._%+-]{6,64}"
            let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            let passwordResult: Bool = passwordPred.evaluate(with: string)
            if !passwordResult {
                throw ValidateInputError.passwordIncorrect
            }
        case .userName:
            let userNameRegEx = "[A-Z0-9a-z._%+-]{2,64}"
            let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
            let userNameResult: Bool = userNamePred.evaluate(with: string)
            if !userNameResult {
                throw ValidateInputError.userNameError
            }
        case .passwordMatch:
            if string != stringForMatching {
                throw ValidateInputError.passwordNotMatch
            }
        case .emptyString:
            if string == "" {
                throw ValidateInputError.emptyString
            }
        }
        
        return true
    }
    
}

