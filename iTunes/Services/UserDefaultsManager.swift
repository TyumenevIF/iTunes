//
//  UserDefaultsManager.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 03.05.2022.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys: String {
        case users
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String,
                  lastName: String,
                  age: Date,
                  phone: String,
                  email: String,
                  password: String) {
        
        let user = User(firstName: firstName,
                        lastName: lastName,
                        age: age,
                        phone: phone,
                        email: email,
                        password: password)
        users.insert(user, at: 0)
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }

    func saveActiveUser(user: User) {
        activeUser = user
    }
}
