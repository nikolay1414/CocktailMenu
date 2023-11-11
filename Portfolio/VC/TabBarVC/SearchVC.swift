//
//  First.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate {
    
    var manager = CocktailManager()
    
    private let popularCollectionView = BaseCollectionView(itemSize: CGSize(width: 180, height: 200), scrollDirection: .vertical)
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setContraints()
        manager.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        popularCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        navigationItem.searchController = searchController
        popularCollectionView.cellDelegate = self
        
    }
    
    func setupView() {
        navigationItem.title = "Search"
        view.addSubview(popularCollectionView)

    }
}

extension SearchViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            popularCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            popularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            popularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            popularCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}

extension SearchViewController: CocktailManagerDelegate {
    func didUpdateMenu(_ cocktailManaget: CocktailManager, data: [CocktailModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            popularCollectionView.data = data
            popularCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            showAlert(title: "Error", message: error.localizedDescription)
            searchController.searchBar.text = ""
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            popularCollectionView.data = []
            popularCollectionView.reloadData()
            return
        }
        manager.fetchCocktailMenu(cocktail: searchText)
    }
}

extension SearchViewController: BaseCollectionViewTapped {
    func cellPressed(model: [Any]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            let vc = ReceprViewController()
            if let cocktailModel = model.first as? CocktailModel {
                vc.nameCocktail.text = cocktailModel.name
                let url = URL(string: cocktailModel.image ?? "")
                vc.setImage(url: url!)
                vc.infoCocktail.text = cocktailModel.instructions
                vc.array = getArry(cocktailModel: cocktailModel)
                self.present(vc, animated: true)
            }
        }
        func getArry (cocktailModel: CocktailModel) -> [String] {
            let ingredients = [
                cocktailModel.strIngredient1,
                cocktailModel.strIngredient2,
                cocktailModel.strIngredient3,
                cocktailModel.strIngredient4,
                cocktailModel.strIngredient5
            ]
            
            let measures = [
                cocktailModel.strMeasure1,
                cocktailModel.strMeasure2,
                cocktailModel.strMeasure3,
                cocktailModel.strMeasure4,
                cocktailModel.strMeasure5
            ]
            
            var combinedIngredients: [String] = []
            
            for (ingredient, measure) in zip(ingredients, measures) {
                if let ingredient = ingredient, let measure = measure {
                    let combined = "\(ingredient) \(measure)"
                    combinedIngredients.append(combined)
                }
            }
            return combinedIngredients
        }
    }
}

