//
//  TableCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TableCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let tableIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.image = UIImage(named: "table")
        return image
    }()
    
    
    let tableName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let tableNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.backgroundColor = UIColor(named: "5")
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        return label
    }()
    
    func  setupView(){
        addSubview(tableIconImage)
        addSubview(tableName)
        addSubview(tableNumber)
        addSubview(colorView)
        
        colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        colorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        tableIconImage.leftAnchor.constraint(equalTo: colorView.leftAnchor, constant: 10).isActive = true
        tableIconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tableIconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tableIconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tableName.leftAnchor.constraint(equalTo: tableIconImage.rightAnchor,constant: 10).isActive = true
        tableName.rightAnchor.constraint(equalTo: tableNumber.leftAnchor,constant: -5).isActive = true
        tableName.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        tableNumber.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tableNumber.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        tableNumber.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tableNumber.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func updateCellData(table: Table){
        tableNumber.text = String(table.id!)
        tableName.text = table.name
        colorView.backgroundColor = table.categoryColor
        tableNumber.backgroundColor = table.categoryColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
