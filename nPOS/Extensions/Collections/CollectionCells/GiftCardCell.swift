//
//  GiftCardCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class GiftCardCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    
    let cardName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let persentageDiscount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor(named: "5")
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()

    func  setupView(){
        addSubview(cardImage)
        addSubview(cardName)
        addSubview(persentageDiscount)
        
        cardImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cardName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cardName.leftAnchor.constraint(equalTo: cardImage.rightAnchor,constant: 5).isActive = true
        cardName.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        cardName.widthAnchor.constraint(equalToConstant: 75).isActive = true
        cardName.rightAnchor.constraint(equalTo: persentageDiscount.leftAnchor,constant: -5).isActive = true
        
        persentageDiscount.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        persentageDiscount.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        persentageDiscount.heightAnchor.constraint(equalToConstant: 35).isActive = true
        persentageDiscount.widthAnchor.constraint(equalToConstant: 35).isActive = true

    }
    
    func updateCellData(card: GiftCard){
        cardName.text = card.name
        persentageDiscount.text = String(card.percentage!)
        cardImage.image = UIImage(named: card.imageName!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
