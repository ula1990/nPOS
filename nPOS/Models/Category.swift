//
//  Category.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 23/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Category: NSObject {
    var id: Int?
    var name: String?
    var color: UIColor?
    
    init(id: Int, name: String,color: UIColor){
        self.id = id
        self.name = name
        self.color = color
        
    }
    
}
