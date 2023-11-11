//
//  CocktailManager.swift
//  Portfolio
//
//  Created by Николай on 17.10.2023.
//

import Foundation

protocol CocktailManagerDelegate: AnyObject {
    func didUpdateMenu (_ cocktailManaget: CocktailManager, data: [CocktailModel])
    func didFailWithError (error: Error)
}

class CocktailManager {
    
    weak var delegate: CocktailManagerDelegate?
    
    func fetchCocktailMenu (cocktail: String) {
        let urlString = R.CocktailApi.apiMenu + cocktail
        performRequest(with: urlString)
    }
    
    func fetchCocktailMenuWithId (id: String) {
        let urlString = R.CocktailApi.apiId + id
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print("Error \(error?.localizedDescription)")
                }
                    if let safeData = data {
                        if let menu = self.parsJSON(cocktailData: safeData) {
                            self.delegate?.didUpdateMenu(self, data: menu)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parsJSON (cocktailData: Data) -> [CocktailModel]? {
        let decode = JSONDecoder()
        var ar = [CocktailModel]()
        do {
            let decodeData = try decode.decode(Drink.self, from: cocktailData)
            
            for drinkDictionary in decodeData.drinks {
                if let name = drinkDictionary["strDrink"],
                   let alcohol = drinkDictionary["strAlcoholic"],
                   let instructions = drinkDictionary["strInstructions"],
                   let imageStr = drinkDictionary["strDrinkThumb"],
                   let strIngredient1 = drinkDictionary["strIngredient1"],
                   let strIngredient2 = drinkDictionary["strIngredient2"],
                   let strIngredient3 = drinkDictionary["strIngredient3"],
                   let strIngredient4 = drinkDictionary["strIngredient4"],
                   let strIngredient5 = drinkDictionary["strIngredient5"],
                   let strMeasure1 = drinkDictionary["strMeasure1"],
                   let strMeasure2 = drinkDictionary["strMeasure2"],
                   let strMeasure3 = drinkDictionary["strMeasure3"],
                   let strMeasure4 = drinkDictionary["strMeasure4"],
                   let strMeasure5 = drinkDictionary["strMeasure5"] {
                    let drink = CocktailModel(name: name, alcohol: alcohol, instructions: instructions, image: imageStr, strIngredient1: strIngredient1, strIngredient2: strIngredient2, strIngredient3: strIngredient3, strIngredient4: strIngredient4, strIngredient5: strIngredient5, strMeasure1: strMeasure1, strMeasure2: strMeasure2, strMeasure3: strMeasure3, strMeasure4: strMeasure4, strMeasure5: strMeasure5)
                    ar.append(drink)
                    
                }
            }
            
        } catch {
            delegate?.didFailWithError(error: error)
            print("Error \(error.localizedDescription)")
            return nil
        }
        return ar
    }
}


