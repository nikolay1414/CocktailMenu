//
//  ViewController.swift
//  Portfolio
//
//  Created by Николай on 16.10.2023.
//

import UIKit
import RealmSwift

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupVC()
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        tabBar.barTintColor = .gray
        tabBar.tintColor = .white
        tabBar.backgroundColor = .blue

    }
    
    private func setupVC() {
        viewControllers = [
            generateNavContr(vc: MainViewController(), title: "Main", image: "house.fill"),
            generateNavContr(vc: FavoriteViewController(), title: "Favorite", image: "heart.circle.fill"),
            generateNavContr(vc: SearchViewController(), title: "Search", image: "magnifyingglass.circle.fill"),
            generateNavContr(vc: ProfileViewController(), title: "Profile", image: "person.circle.fill")
        ]
    }
    
    func generateNavContr(vc: UIViewController, title: String, image: String) -> UINavigationController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(systemName: image)
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}

