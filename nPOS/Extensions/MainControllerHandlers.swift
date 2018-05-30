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
    
    @objc public func temporaryDrinksArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Cola", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 3)
        let item2 = Item(id: "2", name: "Pepsi", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 3)
        let item3 = Item(id: "3", name: "Sprite", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 3)
        let item4 = Item(id: "4", name: "Tonik", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 3)
        let item5 = Item(id: "5", name: "Fanta", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 3)
        let item6 = Item(id: "6", name: "Wasser", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category:3)
        let item7 = Item(id: "7", name: "Orange Jucie", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 3)
        let item8 = Item(id: "8", name: "Apple Jucie", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 3)

        
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
    
    @objc public func temporarySaladsArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Celerv", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 2)
        let item2 = Item(id: "2", name: "Colorful", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 2)
        let item3 = Item(id: "3", name: "Asparagus", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 2)
        let item4 = Item(id: "4", name: "Bavarian", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 2)
        let item5 = Item(id: "5", name: "Deutschlaender", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 2)
        let item6 = Item(id: "6", name: "Field Greens", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 2)
        let item7 = Item(id: "7", name: "Deutschlaender", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 2)
        let item8 = Item(id: "8", name: "Deutschlaender", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 2)
        let item9 = Item(id: "9", name: "Deutschlaender", imageName: "burger2", price: 21.99, vat: 2.14, desc: "Nice", category: 2)

        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        array.append(item9)

        return array
    }
    
    @objc public func temporaryBeersArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Weihenstephan", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 7)
        let item2 = Item(id: "2", name: "Erdinger Kristall", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 7)
        let item3 = Item(id: "3", name: "Spaten", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 7)
        let item4 = Item(id: "4", name: "Paulaner", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 7)
        let item5 = Item(id: "5", name: "Gaffel", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 7)
        let item6 = Item(id: "6", name: "Schneider", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 7)
        let item7 = Item(id: "7", name: "Aecht", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 7)
  
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)

        return array
    }
    
    @objc public func temporaryAppetizersArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Prosciutto Bites", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 1)
        let item2 = Item(id: "2", name: "Grilled Cheese", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 1)
        let item3 = Item(id: "3", name: "CheesBurger", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 1)
        let item4 = Item(id: "4", name: "Bacon Wrapped", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 1)
        let item5 = Item(id: "5", name: "Leeroy Burger", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 1)
        let item6 = Item(id: "6", name: "Ula Burger", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 1)
        let item7 = Item(id: "7", name: "New Burger", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 1)
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

    @objc public func temporaryEntreesArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Egg Yolk", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 5)
        let item2 = Item(id: "2", name: "Perfect Pork", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 5)
        let item3 = Item(id: "3", name: "Oprah Pasta", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 5)
        let item4 = Item(id: "4", name: "Buffalo Chicken", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 5)
        let item5 = Item(id: "5", name: "Leeroy Burger", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 5)
        let item6 = Item(id: "6", name: "Ula Burger", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 5)
        let item7 = Item(id: "7", name: "New Burger", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 5)
        let item8 = Item(id: "8", name: "Old Burger", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 5)
        let item9 = Item(id: "9", name: "Big Mac Burger", imageName: "burger2", price: 21.99, vat: 2.14, desc: "Nice", category: 5)
        let item10 = Item(id: "10", name: "Premium Burger", imageName: "burger3", price: 8.99, vat: 0.55, desc: "Nice", category: 5)
        let item11 = Item(id: "11", name: "Double Burger", imageName: "burger1", price: 3.99, vat: 0.32, desc: "Nice", category: 5)
        let item12 = Item(id: "12", name: "Mix Burger", imageName: "burger2", price: 9.99, vat: 0.99, desc: "Nice", category: 5)
        let item13 = Item(id: "13", name: "Julia Burger", imageName: "burger3", price: 3.99, vat: 0.44, desc: "Nice", category: 5)
        let item14 = Item(id: "14", name: "Big Mac Burger", imageName: "burger1", price: 9.99, vat: 0.99, desc: "Nice", category: 5)
        let item15 = Item(id: "15", name: "Big Mac Burger", imageName: "burger3", price: 6.99, vat: 0.65, desc: "Nice", category: 5)
        let item16 = Item(id: "16", name: "Big Mac Burger", imageName: "burger2", price: 2.99, vat: 0.23, desc: "Nice", category: 5)
        let item17 = Item(id: "17", name: "Big Mac Burger", imageName: "burger3", price: 8.99, vat: 0.87, desc: "Nice", category: 5)
        let item18 = Item(id: "18", name: "Boring Burger", imageName: "burger2", price: 8.99, vat: 0.87, desc: "Nice", category: 5)
        let item19 = Item(id: "19", name: "Awesome Burger", imageName: "burger1", price: 8.99, vat: 0.87, desc: "Nice", category: 5)
        
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
    
    @objc public func temporaryWineArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Gewürztraminer", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 8)
        let item2 = Item(id: "2", name: "Riesling", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 8)
        let item3 = Item(id: "3", name: "Chardonnay", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 8)
        let item4 = Item(id: "4", name: "Sauvignon blanc", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 8)
        let item5 = Item(id: "5", name: "Syrah", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 8)
        let item6 = Item(id: "6", name: "Merlot", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category: 8)
        let item7 = Item(id: "7", name: "Cabernet", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 8)
        let item8 = Item(id: "8", name: "Pinot noir", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 8)
 
        
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
    
    
    @objc public func temporaryDesertsArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Ice cream", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 6)
        let item2 = Item(id: "2", name: "Cheesecake", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 6)
        let item3 = Item(id: "3", name: "Waffle", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 6)
        let item4 = Item(id: "4", name: "Custard", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 6)
        let item5 = Item(id: "5", name: "Sundae", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 6)
        let item6 = Item(id: "6", name: "Apple Pie", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category:6)
        let item7 = Item(id: "7", name: "Sorbet", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 6)
        let item8 = Item(id: "8", name: "Tiramisu", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 6)
        
        
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
    
    @objc public func temporarySpiritsArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Vodka", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 4)
        let item2 = Item(id: "2", name: "Rum", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 4)
        let item3 = Item(id: "3", name: "Grey Goose", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 4)
        let item4 = Item(id: "4", name: "Old Tom Jin", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 4)
        let item5 = Item(id: "5", name: "Jagermister", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 4)
        let item6 = Item(id: "6", name: "Apple Vodka", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category:4)
        let item7 = Item(id: "7", name: "Rum", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 4)
        let item8 = Item(id: "8", name: "Rum", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 4)
        
        
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
