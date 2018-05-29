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
        cell.categoryName.backgroundColor = category.color
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row]
        categoryColorView.backgroundColor = category.color
        selectedCategoryButton.setTitle(category.name, for: .normal)
        categoryId = category.id
        UIView.animate(withDuration: 0.3) {
            self.categoriesWidthAnchor?.isActive = false
            self.categoriesWidthAnchor = self.categoryCollectionView.widthAnchor.constraint(equalToConstant: 0)
            self.categoriesWidthAnchor?.isActive = true
            self.view.layoutIfNeeded()
            self.categoriesShowing = false
        }
        
//        let table = tables[indexPath.row]
//        selectedTable = table.name! + " " + String(table.id!)
//        NotificationCenter.default.post(name: .selectedTable, object: self)
//        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 174, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    
}
