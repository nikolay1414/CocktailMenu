//
//  MainCollectionViewCell.swift
//  Portfolio
//
//  Created by Николай on 19.10.2023.
//
import UIKit
import Foundation
import SDWebImage

protocol FavoriteButtonTapped: AnyObject {
    func buttonPressed ()
}

class MainCollectionViewCell: UICollectionViewCell {
    
    private var model: CocktailModel?
    private var cocktails = FavoriteCocktails()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(checkMarkButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupContraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupContraints()
    }
    
    @objc func checkMarkButtonTapped() {
        if let model = self.model {
            cocktails.name = model.name
            cocktails.image = model.image
            cocktails.instructions = model.instructions
            RealmManager.share.savePlanModel(model: cocktails)
            cocktails = FavoriteCocktails()
            
            let alertController = UIAlertController(title: "Добавлено", message: "Сохранено в избранное", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            if let viewController = self.findViewController() {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension MainCollectionViewCell {
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        clipsToBounds = true
        
    }
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            favoriteButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    func configure(with model: Any) {
        
        if let data = model as? CocktailModel {
            self.model = data
            titleLabel.text = data.name?.uppercased()
            let imageUrl = URL(string: data.image ?? "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")
            imageView.sd_setImage(with: imageUrl)
        }
        if let data = model as? AlcoMenu {
            titleLabel.text = data.name.uppercased()
            let imageUrl = URL(string: data.image )
            imageView.sd_setImage(with: imageUrl)
            favoriteButton.isHidden = true
        }
        if let data = model as? IngredientMenu {
            titleLabel.text = data.name.uppercased()
            let imageUrl = URL(string: data.image )
            imageView.sd_setImage(with: imageUrl)
            favoriteButton.isHidden = true
            
        }
    }
}

