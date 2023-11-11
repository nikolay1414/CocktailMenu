//
//  AlcoManager.swift
//  Portfolio
//
//  Created by Николай on 22.10.2023.
//

import Foundation

protocol AlcoManagerDelegate: AnyObject {
    func didUpdateAcloMenu (_ cocktailManaget: AlcoManager, data: [AlcoMenu])
    func didFailWithError (error: Error)
}

class AlcoManager {
    
    weak var delegate: AlcoManagerDelegate?
    
    func fetchAlcoCoktailMenu (cocktail: String) {
        let urlString = R.CocktailApi.apiAlco + cocktail
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
                            self.delegate?.didUpdateAcloMenu(self, data: drink)
                        }
                    }
                }
                task.resume()
            }
        }
    func parsJSON(cocktailData: Data) -> [AlcoMenu]? {
        let decode = JSONDecoder()
        do {
            let decodeData = try decode.decode(AlcoDrink.self, from: cocktailData)
            
            var menu = [AlcoMenu]()
            
            if let drinks = decodeData.drinks {
                for item in drinks {
                    if let name = item.strDrink,
                       let image = item.strDrinkThumb,
                       let id = item.idDrink {
                        let model = AlcoMenu(name: name, image: image, id: id)
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




