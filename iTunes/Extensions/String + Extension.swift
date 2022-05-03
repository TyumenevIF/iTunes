//
//  String + Extension.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 03.05.2022.
//

import Foundation

extension String {
    
    enum ValidTypes {
        case name
        case phone
        case email
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case phone = "^((\\+7|7|8)+([0-9]){10})$"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9].+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .phone: regex = Regex.phone.rawValue
        case .email: regex = Regex.email.rawValue
        case .password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
