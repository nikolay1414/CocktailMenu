//
//  FavoriteModel.swift
//  Portfolio
//
//  Created by Николай on 29.10.2023.
//

import RealmSwift
import Foundation

class FavoriteCocktails: Object {

    @Persisted var name: String?
    @Persisted var alcohol: String?
    @Persisted var instructions: String?
    @Persisted var image: String?
    
    @Persisted var strIngredient1: String?
    @Persisted var strIngredient2: String?
    @Persisted var strIngredient3: String?
    @Persisted var strIngredient4: String?
    @Persisted var strIngredient5: String?

    @Persisted var strMeasure1: String?
    @Persisted var strMeasure2: String?
    @Persisted var strMeasure3: String?
    @Persisted var strMeasure4: String?
    @Persisted var strMeasure5: String?
}
