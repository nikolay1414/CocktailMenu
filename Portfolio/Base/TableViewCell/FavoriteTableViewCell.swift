//
//  FavoriteTableViewCell.swift
//  Portfolio
//
//  Created by Николай on 26.10.2023.
//

import UIKit
import SDWebImage


class FavoriteTableViewCell: UITableViewCell {
    
    let label = UILabel()
    let image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(label)
        contentView.addSubview(image)
        label.font = .boldSystemFont(ofSize: 20)

        label.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(array: FavoriteCocktails, indexPath: IndexPath) {
        label.text = array.name
        let url = URL(string: array.image!)
        image.sd_setImage(with: url)
    }
}
