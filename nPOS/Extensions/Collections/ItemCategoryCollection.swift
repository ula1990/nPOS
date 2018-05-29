//
//  ItemCategoryCollection.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewItemVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList[indexPath.row]
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! ItemCategoryCell
        cell.categoryName.text = category.name
        cell.backgroundColor = UIColor(named: "background")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row]
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! ItemCategoryCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.8)
        cell.layer.cornerRadius = 2
//        let table = tables[indexPath.row]
//        selectedTable = table.name! + " " + String(table.id!)
//        NotificationCenter.default.post(name: .selectedTable, object: self)
//        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
