//
//  Item.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject {
    var id: String?
    var name: String?
    var imageName: String?
    var price: Double?
    var vat: Double?
    var desc: String?
    var category: Int?
    
    init(id: String, name: String,imageName: String, price: Double,vat: Double, desc: String, category: Int){
        self.id = id
        self.name = name
        self.imageName = imageName
        self.price = price
        self.vat = vat
        self.desc = desc
        self.category = category
    }
    
}
