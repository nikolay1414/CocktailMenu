//
//  UserDafManager.swift
//  Portfolio
//
//  Created by Николай on 17.10.2023.
//

import Foundation

class UserDefManager {
    static var share = UserDefManager()
    
    func saveSettings (model: ModelAuth) {
        let defaults = UserDefaults.standard
        defaults.set(model.firstName, forKey: "name")
        defaults.set(model.lastName, forKey: "lastName")
        defaults.set(model.email, forKey: "email")
        defaults.set(model.password, forKey: "password")
        defaults.set(model.isfirst, forKey: "bool")
        
        defaults.synchronize()
    }
}

