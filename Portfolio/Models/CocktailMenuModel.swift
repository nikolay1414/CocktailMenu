//
//  CocktailModel.swift
//  Portfolio
//
//  Created by Николай on 17.10.2023.
//

import Foundation

struct Drink: Codable {
    let drinks: [[String: String?]]
}

struct CocktailModel: Codable {
    let name: String?
    let alcohol: String?
    let instructions: String?
    let image: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?

    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
}



