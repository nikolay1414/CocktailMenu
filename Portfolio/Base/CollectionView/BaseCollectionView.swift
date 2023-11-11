//
//  CollectionView.swift
//  Portfolio
//
//  Created by Николай on 19.10.2023.
//

import Foundation
import UIKit

protocol BaseCollectionViewTapped: AnyObject {
    func cellPressed(model: [Any])
}

class BaseCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
    

    var data: [Any] = []
    weak var cellDelegate: BaseCollectionViewTapped?
    init(itemSize: CGSize, scrollDirection: ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: layout)
        self.dataSource = self
        self.delegate = self
        clipsToBounds = true
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath) as! MainCollectionViewCell
        cell.configure(with: data[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = data[indexPath.row]
         self.cellDelegate?.cellPressed(model: [selectedData])
    }
}

