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
            idTextField.text = ""
            tableNameTextField.text = ""
            view.endEditing(true)
        }
        
    }
    
    @objc public func addToTableList(id: Int, name: String,  color: UIColor){
        let newTable = Table(id: id, name: name, categoryColor: color)
        tables.append(newTable)
        tableCollectionView.reloadData()
    }
    
    
    @objc public func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func handleSelectColor(){
        let colorVC = UINavigationController(rootViewController: SelectColorVC())
        colorVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(colorVC, animated: true, completion: nil)
    }
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
   @objc public func temporaryTableArray()->[Table]{
        var array: [Table] = []
        let item1 = Table(id: 1,name: "Table",categoryColor: UIColor(named: "1")!)
        let item2 = Table(id: 2,name: "Table",categoryColor: (UIColor(named: "2"))!)
        let item3 = Table(id: 3,name: "Table",categoryColor: UIColor(named: "3")!)
        let item4 = Table(id: 4,name: "Table",categoryColor: UIColor(named: "4")!)
        let item5 = Table(id: 5,name: "Table",categoryColor: UIColor(named: "5")!)
        let item6 = Table(id: 6,name: "Table",categoryColor: UIColor(named: "6")!)
        let item7 = Table(id: 7,name: "Table",categoryColor: UIColor(named: "7")!)
        let item8 = Table(id: 8,name: "Table",categoryColor: UIColor(named: "1")!)
        let item9 = Table(id: 9,name: "Table",categoryColor: UIColor(named: "1")!)
        let item10 = Table(id: 10,name: "Table",categoryColor: UIColor(named: "4")!)
        let item11 = Table(id: 11,name: "Table",categoryColor: UIColor(named: "4")!)
        let item12 = Table(id: 12,name: "Table",categoryColor: UIColor(named: "8")!)
        let item13 = Table(id: 13,name: "Table",categoryColor: UIColor(named: "5")!)
        let item14 = Table(id: 14,name: "Table",categoryColor: UIColor(named: "5")!)
        let item15 = Table(id: 15,name: "Table",categoryColor: UIColor(named: "1")!)
        let item16 = Table(id: 16,name: "Table",categoryColor: UIColor(named: "1")!)
        let item17 = Table(id: 17,name: "Stuff",categoryColor: UIColor(named: "1")!)
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        array.append(item9)
        array.append(item10)
        array.append(item11)
        array.append(item12)
        array.append(item13)
        array.append(item14)
        array.append(item15)
        array.append(item16)
        array.append(item17)
        
        return array
    }
    
    
}
