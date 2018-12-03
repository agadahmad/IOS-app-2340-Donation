//
//  UserAuthentication.swift
//  drackriOS
//
//  Created by Jonathan Valldejuli on 11/20/18.
//  Copyright © 2018 Jonathan Valldejuli. All rights reserved.
//

import Foundation

enum AccountType: Int, Codable {
    case user, locationEmployee, admin
    static let values: [AccountType] = [.user, .locationEmployee, .admin]
    var name: String {
        switch self {
        case .user:
            return "User"
        case .locationEmployee:
            return "Location Employee"
        case .admin:
            return "Admin"
        }
    }
}

class Account: Codable {
    let email: String
    let name: String
    let password: String
    let type: AccountType
    init(email: String, name: String, password: String, type: AccountType) {
        self.email = email
        self.name = name
        self.password = password
        self.type = type
    }
}

class UserAuthentication {
    
    static var signedInUser: Account?
    
    static var accounts: [Account] = {
        guard let accountsData = UserDefaults.standard.data(forKey: "accounts") else {
            return []
        }
        return try! JSONDecoder().decode([Account].self, from: accountsData)
    }() {
        didSet {
            let accountsData = try! JSONEncoder().encode(accounts)
            UserDefaults.standard.set(accountsData, forKey: "accounts")
        }
    }
    
    static func signIn(email: String, password: String) -> Bool {
        guard let account = accounts.first(where: {
            $0.email == email && $0.password == password
        }) else {
            return false
        }
        signedInUser = account
        return true
    }
    
    static func register(email: String, name: String, password: String, type: AccountType) {
        let account = Account(email: email, name: name, password: password, type: type)
        accounts.append(account)
        signedInUser = account
    }
    
}
