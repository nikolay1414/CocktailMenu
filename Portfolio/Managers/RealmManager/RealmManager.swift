//
//  RealmManager.swift
//  Portfolio
//
//  Created by Николай on 29.10.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let share = RealmManager()
    
    private init () {}
    
    let realm = try! Realm()
    
    func savePlanModel (model: FavoriteCocktails) {
        try! realm.write {
            realm.add(model)
        }
    }
    func deletePlanModel (model: FavoriteCocktails) {
        try! realm.write {
            realm.delete(model)
        }
    }
}
