//
//  AlcoModel.swift
//  Portfolio
//
//  Created by Николай on 22.10.2023.
//

import Foundation


struct AlcoDrink: Codable {
    let drinks: [DrinkElement]?
}

struct DrinkElement: Codable {
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
}

struct AlcoMenu {
    let name: String
    let image: String
    let id: String
}
