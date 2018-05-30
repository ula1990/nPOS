//
//  DiscountCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 30/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class DiscountCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let discountIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.image = UIImage(named: "discount_icon")
        return image
    }()
    
    
    let discountName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let discountPercentage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor(named: "7")
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        return label
    }()
    
    func  setupView(){
        addSubview(discountIconImage)
        addSubview(discountName)
        addSubview(discountPercentage)

        discountIconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        discountIconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        discountIconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        discountIconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        discountName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        discountName.leftAnchor.constraint(equalTo: discountIconImage.rightAnchor,constant: 10).isActive = true
        discountName.rightAnchor.constraint(equalTo: discountPercentage.leftAnchor,constant: -5).isActive = true
        discountName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        discountPercentage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        discountPercentage.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        discountPercentage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        discountPercentage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func updateCellData(discount: Discount){
        discountName.text = discount.name
        discountPercentage.text = String(discount.percentage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
