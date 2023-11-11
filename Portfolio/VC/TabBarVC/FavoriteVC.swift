//
//  FavoriteVC.swift
//  Portfolio
//
//  Created by Николай on 17.10.2023.
//

import UIKit
import RealmSwift

class FavoriteViewController: UITableViewController {

    let localRealm = try! Realm()
    var cocktails: Results<FavoriteCocktails>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "cell")
        get()
    }
    private func config() {
        title = "Favorite cocktails"
        tableView.delegate = self
        tableView.dataSource = self
        cocktails = localRealm.objects(FavoriteCocktails.self).elements
        tableView.reloadData()
    }
    
    func get () {
        cocktails = localRealm.objects(FavoriteCocktails.self).sorted(byKeyPath: "name")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        let model = cocktails[indexPath.row]
        cell.config(array: model, indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = cocktails[indexPath.row]
        let deleteAction = UIContextualAction(style: .normal, title: "Удалить") { _, _, complitionHandler in
            RealmManager.share.deletePlanModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


