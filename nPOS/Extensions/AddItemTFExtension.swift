//
//  AddItemTFExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewItemVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        //Prevent "0" characters as the first characters. (i.e.: There should not be values like "003" "01" "000012" etc.)
        if itemPriceTF.text?.count == 0 && string == "0" {
            Alert.showBasic(title: "Incorrect input", msg: "First number can't be 0", vc: self)
            return false
        }
        
        //Limit the character count to 10.
        if ((itemPriceTF.text!) + string).count > 7 {
            Alert.showBasic(title: "Max Length", msg: "Maximum amount of numbers in the field is 7", vc: self)
            return false
        }
        
        //Have a decimal keypad. Which means user will be able to enter Double values. (Needless to say "." will be limited one)
        if (itemPriceTF.text?.contains("."))! && string == "." {
            Alert.showBasic(title: "Incorrect input", msg: "Please check the field", vc: self)
            return false
        }
        
        //Only allow numbers. No Copy-Paste text values.
        let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789.")
        let textCharacterSet = CharacterSet.init(charactersIn: itemPriceTF.text! + string)
        if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if itemPriceTF.text?.isEmpty == true{
            print(Error.self)
        }else{
            taxAmount = 0.3 * Double(itemPriceTF.text!)!
            nettoAmount = 0.7 * Double(itemPriceTF.text!)!
            itemPriceNettoResult.text = "$ " + String(nettoAmount!)
            itemPriceTaxResult.text = "$ " + String(taxAmount!)
        }
        
        
    }
}
