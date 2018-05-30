//
//  Order.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 30/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Order: NSObject {
    var id: String?
    var timestamp: String?
    var taxes: Double?
    var totalPrice: Double?
    var items: [Item]?
    
    init(id: String, timestamp: String,taxes: Double, totalPrice: Double,items: [Item]){
        self.id = id
        self.timestamp = timestamp
        self.taxes = taxes
        self.totalPrice = totalPrice
        self.items = items
    }
    
}
