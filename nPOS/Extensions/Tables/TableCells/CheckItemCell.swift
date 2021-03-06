//
//  CheckItemCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 31/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CheckItemCell: UITableViewCell {

    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    

    
    
    fileprivate func setupViews(){
        
        
        itemNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        itemNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        itemNameLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
        
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(itemNameLabel)
        addSubview(priceLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDataInCell(item: Item){
        itemNameLabel.text = item.name
        priceLabel.text = "$" + String(item.price!) + "-"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
