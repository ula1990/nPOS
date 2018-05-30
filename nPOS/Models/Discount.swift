//
//  Discount.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 30/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Discount: NSObject {
    var id: Int?
    var name: String?
    var percentage: Int?
    var rate: Double?
    
    init(id: Int, name: String, percentage: Int, rate: Double){
        self.id = id
        self.name = name
        self.percentage = percentage
        self.rate = rate
    }
    
}
