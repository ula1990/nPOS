//
//  TotalCalculationExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 28/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC {
    public func calculateTotal(){
        self.counterOfItemsLabel.text = String(self.itemInCart.count)
        self.subTotalResultLabel.text = "$" + String(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +))
        self.taxResultLabel.text = "$" +  String(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +))
        self.totalResultLabel.text = "$" +  String(Double(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +)) + Double(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +)))
    }
}
