//
//  AddGiftCardExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 28/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension GiftCardVC {
    
    @objc public func handleAddGiftCard(){
            if amountTextField.text!.isEmpty == true {
                Alert.showBasic(title: "Check Amount", msg: "Each card should have amount", vc: self)
            }else if giftCardNameTextField.text!.isEmpty == true {
                Alert.showBasic(title: "Check Name", msg: "Each card should have Name", vc: self)
            }else{
                addToCardList(amount: Double(amountTextField.text!)!, name: giftCardNameTextField.text!)
                amountTextField.text = ""
                giftCardNameTextField.text = ""
            }
            
        }
        
        func addToCardList(amount: Double, name: String){
            let newCard = Item(id: "1", name: name , imageName: "card", price: amount, vat: 0, desc: "Gift Card")
            cards.append(newCard)
            giftCardCollectionView.reloadData()
    
    }
    
    
}
