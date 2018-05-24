//
//  ItemCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "1")
        return view
    }()
    
    
    let itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    
    func  setupView(){
        addSubview(colorView)
        addSubview(itemName)
        
        colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        colorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        itemName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemName.leftAnchor.constraint(equalTo: colorView.rightAnchor,constant: 20).isActive = true
        itemName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        itemName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    func updateCellData(item: Item){
        itemName.text = item.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
 
}
