//
//  ItemCategoryCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class ItemCategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    func  setupView(){
        addSubview(categoryName)
        
        categoryName.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        categoryName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        categoryName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
