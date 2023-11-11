//
//  MainViewController.swift
//  Portfolio
//
//  Created by Николай on 22.10.2023.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {
    
    var menuManager = CocktailManager()
    var alcoManager = AlcoManager()
    var ingtManager = IngredientManager()
    
    private let leftStackView = UIStackView.stackView
    private let rightStackView = UIStackView.stackView
    private let stackView = UIStackView.stackView
    private var favoriteArray = [CocktailModel]()
    
    
    private let menuCollectionView = BaseCollectionView(itemSize: CGSize(width: 180, height: 200), scrollDirection: .horizontal)
    
    private let alcoCollectionView = BaseCollectionView(itemSize: CGSize(width: 180, height: 200), scrollDirection: .vertical)
    
    private let ingredientscollectionView = BaseCollectionView(itemSize: CGSize(width: 180, height: 200), scrollDirection: .vertical)
    
    private let alcoholSegmentedControll: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Alcohol","No alco"])
        sc.selectedSegmentIndex = 0
        sc.apportionsSegmentWidthsByContent = true
        sc.addTarget(self, action: #selector(alcoSegmentTapped), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let ingredientsSegmentedControll: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Vod","Gin","Teq","Rum"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(igredSegmentTapped), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setContraints()
        config()
        
        menuManager.fetchCocktailMenu(cocktail: "")
        alcoManager.fetchAlcoCoktailMenu(cocktail: "Alcoholic")
        ingtManager.fetchCocktailMenu(ingredient: "Vodka")

    }
    
    func setupView() {
        view.addSubview(menuCollectionView)
        view.addSubview(alcoholSegmentedControll)
        view.addSubview(alcoCollectionView)
        view.addSubview(ingredientsSegmentedControll)
        view.addSubview(ingredientscollectionView)
    }
    
    func config() {
        view.backgroundColor = .white
        menuCollectionView.cellDelegate = self
        alcoCollectionView.cellDelegate = self
        ingredientscollectionView.cellDelegate = self
        
        menuManager.delegate = self
        alcoManager.delegate = self
        ingtManager.delegate = self
        
        
        menuCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        alcoCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        ingredientscollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        navigationItem.title = "MENU"
    }
    
    @objc private func alcoSegmentTapped () {
        switch alcoholSegmentedControll.selectedSegmentIndex {
        case 0: alcoManager.fetchAlcoCoktailMenu(cocktail: "Alcoholic")
            alcoCollectionView.reloadData()
        case 1: alcoManager.fetchAlcoCoktailMenu(cocktail: "Non_Alcoholic")
            alcoCollectionView.reloadData()
        default:
            alcoManager.fetchAlcoCoktailMenu(cocktail: "Alcoholic")
            alcoCollectionView.reloadData()
        }
    }
    
    @objc private func igredSegmentTapped () {
        switch ingredientsSegmentedControll.selectedSegmentIndex {
        case 0: ingtManager.fetchCocktailMenu(ingredient: "Vodka")
            alcoCollectionView.reloadData()
        case 1: ingtManager.fetchCocktailMenu(ingredient: "Gin")
            alcoCollectionView.reloadData()
        case 2: ingtManager.fetchCocktailMenu(ingredient: "Tequila")
            alcoCollectionView.reloadData()
        case 3: ingtManager.fetchCocktailMenu(ingredient: "Rum")
            alcoCollectionView.reloadData()
        default:
            ingtManager.fetchCocktailMenu(ingredient: "Vodka")
        }
    }
}

extension MainViewController {
    private func setContraints() {
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            menuCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            alcoholSegmentedControll.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            alcoholSegmentedControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            alcoholSegmentedControll.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -25),
            alcoholSegmentedControll.heightAnchor.constraint(equalToConstant: 30),
            
            alcoCollectionView.topAnchor.constraint(equalTo: alcoholSegmentedControll.bottomAnchor),
            alcoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            alcoCollectionView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            alcoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            
            ingredientsSegmentedControll.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor),
            ingredientsSegmentedControll.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            ingredientsSegmentedControll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ingredientsSegmentedControll.heightAnchor.constraint(equalToConstant: 30),
            
            ingredientscollectionView.topAnchor.constraint(equalTo: alcoholSegmentedControll.bottomAnchor),
            ingredientscollectionView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            ingredientscollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ingredientscollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35),
            
        ])
    }
}

extension MainViewController: CocktailManagerDelegate {
    
    func didUpdateMenu(_ cocktailManaget: CocktailManager, data: [CocktailModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            menuCollectionView.data = data
            menuCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

extension MainViewController: AlcoManagerDelegate {
    func didUpdateAcloMenu(_ cocktailManaget: AlcoManager, data: [AlcoMenu]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            alcoCollectionView.data = data
            alcoCollectionView.reloadData()
        }
    }
}

extension MainViewController: IngredientManagerDelegate {
    func didUpdateIngredientMenu(_ cocktailManaget: IngredientManager, data: [IngredientMenu]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            ingredientscollectionView.data = data
            ingredientscollectionView.reloadData()
        }
    }
}

extension MainViewController: BaseCollectionViewTapped {
    func cellPressed(model: [Any]) {
        let vc = ReceprViewController()
        if let cocktailModel = model.first as? CocktailModel {
            vc.nameCocktail.text = cocktailModel.name
            let url = URL(string: cocktailModel.image ?? "")
            vc.setImage(url: url!)
            vc.infoCocktail.text = cocktailModel.instructions
            vc.array = getArry(cocktailModel: cocktailModel)
            self.present(vc, animated: true)
        }
        if let cocktailModel = model.first as? AlcoMenu {
            IdManager.shared.fetchCocktailMenuId(with: cocktailModel.id) { [weak self] model in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    vc.nameCocktail.text = cocktailModel.name
                    let url = URL(string: cocktailModel.image)
                    vc.setImage(url: url!)
                    vc.infoCocktail.text = model.instructions
                    vc.array = getArry(cocktailModel: model)
                    self.present(vc, animated: true)
                }
            }
            
        }
        if let cocktailModel = model.first as? IngredientMenu {
            IdManager.shared.fetchCocktailMenuId(with: cocktailModel.id) { [weak self] model in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    vc.nameCocktail.text = cocktailModel.name
                    let url = URL(string: cocktailModel.image)
                    vc.setImage(url: url!)
                    vc.infoCocktail.text = model.instructions
                    vc.array = getArry(cocktailModel: model)
                    
                    self.present(vc, animated: true)
                }
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

extension MainViewController: FavoriteButtonTapped {
    func buttonPressed() {
        DispatchQueue.main.async {
            self.showAlert(title: "Добавлено", message: "Cохранено в избранное")
            print("tap")
        }
    }
}
