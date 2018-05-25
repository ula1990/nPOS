//
//  SelectColorPickerExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension SelectColorVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return colorList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorList[row].nameOfCategory
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionDelegate?.colorReceived(selectedColor: colorList[row].categoryColor)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: colorList[row].nameOfCategory!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return attributedString
    }
    
}
