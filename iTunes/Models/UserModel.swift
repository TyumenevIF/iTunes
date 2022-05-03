//
//  UserModel.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 03.05.2022.
//

import Foundation

struct User: Codable {
    let firstName: String
//    let lastName: String
    let age: Date
    let phone: String
    let email: String
    let password: String
}
