//
//  MainCollectionExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == itemCollectionView {
        return items.count
        }else if collectionView == categoryCollectionView{
            return categoryList.count
        }else{
           return menuBar.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == itemCollectionView {
        let item = items[indexPath.row]
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! ItemCell
        cell.backgroundColor = UIColor(named: "background")
        cell.updateCellData(item: item)
        return cell
        }else if collectionView == categoryCollectionView{
            let category = categoryList[indexPath.row]
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCell
            cell.backgroundColor = category.color
            cell.categoryName.text = category.name
            return cell
        }else{
            let title = menuBar[indexPath.row]
            let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
            cell.updateCellData(title: title.name)
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(named: "darkBackground")?.cgColor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView {
        let item = items[indexPath.row]
        itemInCart.append(item)
        self.cartTableView.reloadData()
        counterOfItemsLabel.text = String(itemInCart.count)
        subTotalResultLabel.text = "$" + String(itemInCart.compactMap({ Double($0.price!) }).reduce(0, +))
        taxResultLabel.text = "$" +  String(itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +))
        totalResultLabel.text = "$" +  String(Double(itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +)) + Double(itemInCart.compactMap({ Double($0.price!) }).reduce(0, +)))
        }else if collectionView == categoryCollectionView{
            print(Error.self)
        }else{
            let menu = menuBar[indexPath.row]
            let menuVC = UINavigationController(rootViewController: menu.viewController!)
            present(menuVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemCollectionView {
            return CGSize(width: 175, height: 90)
        }else if collectionView == categoryCollectionView{
            return CGSize(width: 175, height: 130)
        }else{
            return CGSize(width: 175, height: 58)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         if collectionView == itemCollectionView {
            return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
         }else if collectionView == categoryCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         }else{
            return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        }
    }
    
    
    
}
