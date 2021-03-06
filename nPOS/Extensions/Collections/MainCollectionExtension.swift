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
            if tableLabel.text == "Table #"{
                Alert.showBasic(title: "Select Table", msg: "To start order you need to select table.", vc: self)
            }else{
                itemInCart.append(item)
                self.cartTableView.reloadData()
                counterOfItemsLabel.text = String(itemInCart.count)
                self.calculateTotal()
            }
        
        }else if collectionView == categoryCollectionView{
            let category = categoryList[indexPath.row]
            if category.id == 1{
                items.removeAll()
                items = temporaryAppetizersArray()
                reloadCategoryData()
            }else if category.id == 2{
                items.removeAll()
                items = temporarySaladsArray()
                reloadCategoryData()
            }else if category.id == 3{
                items.removeAll()
                items = temporaryDrinksArray()
                reloadCategoryData()
            }else if category.id == 4{
                items.removeAll()
                items = temporarySpiritsArray()
                reloadCategoryData()
            }else if category.id == 5{
                items.removeAll()
                items = temporaryEntreesArray()
                reloadCategoryData()
            }else if category.id == 6{
                items.removeAll()
                items = temporaryDesertsArray()
                reloadCategoryData()
            }else if category.id == 7{
                items.removeAll()
                items = temporaryBeersArray()
                reloadCategoryData()
            }else if category.id == 8{
                items.removeAll()
                items = temporaryWineArray()
                reloadCategoryData()
            }else{
                items.removeAll()
                items = temporaryArray()
                reloadCategoryData()
            }
        }else{
            let menu = menuBar[indexPath.row]
            let menuVC = UINavigationController(rootViewController: menu.viewController!)
            menuVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(menuVC, animated: true, completion: nil)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == itemCollectionView {
            return CGSize(width: 175, height: 70)
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
