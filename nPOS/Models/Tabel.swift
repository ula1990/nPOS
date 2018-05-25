//
//  Tabel.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Table: NSObject {
    var id: Int?
    var name: String?
    var categoryColor: UIColor?
    
    init(id: Int,name: String, categoryColor: UIColor){
        self.id = id
        self.name = name
        self.categoryColor = categoryColor
    }
}

