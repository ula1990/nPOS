//
//  MainControllerHandlers.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC {

    @objc public func addCreatedItem(id: String , name: String, imageName: String, price: Double, vat: Double, desc: String, category: Int){
        let item = Item(id: id, name: name, imageName: imageName, price: price, vat: vat, desc: desc, category: category)
        items.append(item)
        itemCollectionView.reloadData()
    }
    

    
}
