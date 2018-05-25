//
//  Color.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Color: NSObject {
    var nameOfCategory: String?
    var categoryColor: UIColor?
    
    init(nameOfCategory: String, categoryColor: UIColor){
        self.nameOfCategory = nameOfCategory
        self.categoryColor = categoryColor
    }
}
