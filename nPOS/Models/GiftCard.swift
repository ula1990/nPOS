//
//  GiftCard.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class GiftCard: NSObject {
    var id: String?
    var name: String?
    var imageName: String?
    var percentage: Int?
    
    init(id: String, name: String,imageName: String, percentage: Int){
        self.id = id
        self.name = name
        self.imageName = imageName
        self.percentage = percentage
    }
    
}
