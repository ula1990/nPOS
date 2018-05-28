//
//  AddTableExtension.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 28/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension TableVC {
    
    @objc public func handleAddTable(){
        if idTextField.text!.isEmpty == true {
            Alert.showBasic(title: "Check ID", msg: "Each table should have ID", vc: self)
        }else if tableNameTextField.text!.isEmpty == true {
            Alert.showBasic(title: "Check Table Name", msg: "Each table should have Name", vc: self)
        }else{
            addToTableList(id: Int(idTextField.text!)!, name: tableNameTextField.text!, color: selectColorButton.backgroundColor!)
        }
        
    }
    
    func addToTableList(id: Int, name: String,  color: UIColor){
        let newTable = Table(id: id, name: name, categoryColor: color)
        tables.append(newTable)
        tableCollectionView.reloadData()
    }
    
    
}
