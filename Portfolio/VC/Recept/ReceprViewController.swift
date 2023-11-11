//
//  ReceprViewController.swift
//  Portfolio
//
//  Created by Николай on 23.10.2023.
//

import Foundation
import UIKit
import SDWebImage

final class ReceprViewController: UIViewController {
    
    var array = [String]()
    
    let nameCocktail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let cocktailImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.clipsToBounds = true
        tv.separatorColor = .clear
        tv.accessibilityElementsHidden = true
        tv.bounces = false
        tv.estimatedRowHeight = 44
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let infoCocktail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConts()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReceptTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(nameCocktail)
        view.addSubview(cocktailImage)
        view.addSubview(infoCocktail)
        view.addSubview(tableView)
    }
    
    func setImage(url :URL) {
        cocktailImage.sd_setImage(with: url)
    }
}

extension ReceprViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReceptTableViewCell
        cell.config(array: self.array, indexPath: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ReceprViewController {
    private func setConts() {
        NSLayoutConstraint.activate([
            
            cocktailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cocktailImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            cocktailImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            cocktailImage.heightAnchor.constraint(equalToConstant: 250),
            
            nameCocktail.topAnchor.constraint(equalTo: cocktailImage.bottomAnchor, constant: 10),
            nameCocktail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            nameCocktail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            tableView.topAnchor.constraint(equalTo: nameCocktail.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(array.count * 44)),
            
            infoCocktail.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            infoCocktail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoCocktail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

