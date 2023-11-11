//
//  IngredientManager.swift
//  Portfolio
//
//  Created by Николай on 22.10.2023.
//

import Foundation

import Foundation

protocol IngredientManagerDelegate: AnyObject {
    func didUpdateIngredientMenu (_ cocktailManaget: IngredientManager, data: [IngredientMenu])
    func didFailWithError (error: Error)
}

class IngredientManager {
    
    weak var delegate: IngredientManagerDelegate?
    
    func fetchCocktailMenu (ingredient: String) {
        let urlString = R.CocktailApi.apiIngredient + ingredient
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let jsonData = data {
                        if let drink = self.parsJSON(cocktailData: jsonData) {
                            self.delegate?.didUpdateIngredientMenu(self, data: drink)
                        }
                    }
                }
                task.resume()
            }
        }
    func parsJSON(cocktailData: Data) -> [IngredientMenu]? {
        let decode = JSONDecoder()
        do {
            let decodeData = try decode.decode(AlcoDrink.self, from: cocktailData)
            
            var menu = [IngredientMenu]()
            
            if let drinks = decodeData.drinks {
                for item in drinks {
                    if let name = item.strDrink,
                       let image = item.strDrinkThumb,
                       let id = item.idDrink {
                        let model = IngredientMenu(name: name, image: image, id: id)
                        menu.append(model)
                    }
                }
            }
            
            return menu
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}




