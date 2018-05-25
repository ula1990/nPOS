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
        return label
    }()
    
    let persentageDiscount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor(named: "4")
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()

    func  setupView(){
        addSubview(cardImage)
        addSubview(cardName)
        addSubview(persentageDiscount)
        
        cardImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardImage.topAnchor.constraint(equalTo: self.topAnchor,constant: -10).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        cardName.topAnchor.constraint(equalTo: cardImage.bottomAnchor,constant: -1).isActive = true
        cardName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        cardName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cardName.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        persentageDiscount.topAnchor.constraint(equalTo: cardImage.bottomAnchor,constant: -1).isActive = true
        persentageDiscount.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        persentageDiscount.heightAnchor.constraint(equalToConstant: 40).isActive = true
        persentageDiscount.widthAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    func updateCellData(card: GiftCard){
        cardName.text = card.name
        persentageDiscount.text = String(card.percentage!) + "%"
        cardImage.image = UIImage(named: card.imageName!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
