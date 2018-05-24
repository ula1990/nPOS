//
//  MenuModel.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Menu: NSObject {
    var name: String?
    var viewController: UIViewController?
    
    init(name: String,viewController: UIViewController?){
        self.name = name
        self.viewController = viewController
    }
    
}
