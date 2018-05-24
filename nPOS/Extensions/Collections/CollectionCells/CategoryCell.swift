//
//  CategoryCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 23/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    let categoryName: UILabel = {
         let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    func  setupView(){
        addSubview(categoryName)
        
        categoryName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        categoryName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        categoryName.widthAnchor.constraint(equalToConstant: 110).isActive = true

            }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
