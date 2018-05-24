//
//  MenuCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 23/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(menuTitle)
        setupView()
    }
    
    let menuTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    func setupView(){
        menuTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menuTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuTitle.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        menuTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    func updateCellData(title: String?){
        menuTitle.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
