//
//  MainControllerHandlers.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension MainVC {

    @objc public func addCreatedItem(id: String , name: String, imageName: String, price: Double, vat: Double, desc: String, category: Int){
        let item = Item(id: id, name: name, imageName: imageName, price: price, vat: vat, desc: desc, category: category)
        items.append(item)
        itemCollectionView.reloadData()
    }
    @objc public func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    
    @objc public func fetchUserAndSetupNavBarTitle(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
                
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImageUrl = dictionary["profileImageUrl"] as? String
                self.setupNavBarWithUser(user: user)
            }
        })
        
    }
    
    @objc public func handleLogout(){
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        let loginControlller = LoginController()
        loginControlller.mainController = self
        present(loginControlller, animated: true, completion: nil)
    }

    @objc public func temporaryArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Big Mac Burger", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 1)
        let item2 = Item(id: "2", name: "Chiken Burger", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 2)
        let item3 = Item(id: "3", name: "CheesBurger", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 3)
        let item4 = Item(id: "4", name: "El Maco Burger", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 4)
        let item5 = Item(id: "5", name: "Leeroy Burger", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 1)
        let item6 = Item(id: "6", name: "Ula Burger", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 1)
        let item7 = Item(id: "7", name: "New Burger", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 6)
        let item8 = Item(id: "8", name: "Old Burger", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 1)
        let item9 = Item(id: "9", name: "Big Mac Burger", imageName: "burger2", price: 21.99, vat: 2.14, desc: "Nice", category: 1)
        let item10 = Item(id: "10", name: "Premium Burger", imageName: "burger3", price: 8.99, vat: 0.55, desc: "Nice", category: 1)
        let item11 = Item(id: "11", name: "Double Burger", imageName: "burger1", price: 3.99, vat: 0.32, desc: "Nice", category: 1)
        let item12 = Item(id: "12", name: "Mix Burger", imageName: "burger2", price: 9.99, vat: 0.99, desc: "Nice", category: 1)
        let item13 = Item(id: "13", name: "Julia Burger", imageName: "burger3", price: 3.99, vat: 0.44, desc: "Nice", category: 1)
        let item14 = Item(id: "14", name: "Big Mac Burger", imageName: "burger1", price: 9.99, vat: 0.99, desc: "Nice", category: 1)
        let item15 = Item(id: "15", name: "Big Mac Burger", imageName: "burger3", price: 6.99, vat: 0.65, desc: "Nice", category: 1)
        let item16 = Item(id: "16", name: "Big Mac Burger", imageName: "burger2", price: 2.99, vat: 0.23, desc: "Nice", category: 1)
        let item17 = Item(id: "17", name: "Big Mac Burger", imageName: "burger3", price: 8.99, vat: 0.87, desc: "Nice", category: 1)
        let item18 = Item(id: "18", name: "Boring Burger", imageName: "burger2", price: 8.99, vat: 0.87, desc: "Nice", category: 1)
        let item19 = Item(id: "19", name: "Awesome Burger", imageName: "burger1", price: 8.99, vat: 0.87, desc: "Nice", category: 1)
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        array.append(item9)
        array.append(item10)
        array.append(item11)
        array.append(item12)
        array.append(item13)
        array.append(item14)
        array.append(item15)
        array.append(item16)
        array.append(item17)
        array.append(item18)
        array.append(item19)
        return array
    }
    
    @objc public func temporaryCategoryArray()->[Category]{
        var array: [Category] = []
        let item1 = Category(id: 1, name: "Appetizers", color: UIColor(named: "1")!)
        let item2 = Category(id: 2, name: "Salads", color: UIColor(named: "2")!)
        let item3 = Category(id: 3, name: "Drinks", color: UIColor(named: "3")!)
        let item4 = Category(id: 4, name: "Spirits", color: UIColor(named: "4")!)
        let item5 = Category(id: 5, name: "Entrees", color: UIColor(named: "5")!)
        let item6 = Category(id: 6, name: "Desserts", color: UIColor(named: "6")!)
        let item7 = Category(id: 7, name: "Beers", color: UIColor(named: "7")!)
        let item8 = Category(id: 8, name: "Wine", color: UIColor(named: "8")!)
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        
        return array
    }
    
    @objc public func temporaryMenuArray()->[Menu]{
        var array: [Menu] = []
        let item1 = Menu(name: "New Item", viewController: NewItemVC())
        let item2 = Menu(name: "Find Item", viewController: FindItemVC())
        let item3 = Menu(name: "Transactions", viewController: TransactionsVC())
        let item4 = Menu(name: "Gift Cards", viewController: GiftCardVC())
        let item5 = Menu(name: "Discounts", viewController: DiscountVC())
        let item6 = Menu(name: "Table", viewController: TableVC())
        let item7 = Menu(name: "Open Cashdrawer", viewController: CashDrawerVC())
        let item8 = Menu(name: "Support", viewController: SupportVC())
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        
        return array
    }

    
}
