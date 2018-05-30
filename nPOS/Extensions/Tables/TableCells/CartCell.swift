//
//  CartCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    let leftColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "4")?.withAlphaComponent(0.5)
        return view
    }()
    
    let rightColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "1")?.withAlphaComponent(0.5)
        return view
    }()
    
    
    fileprivate func setupViews(){
        
        leftColorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        leftColorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        leftColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        leftColorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        rightColorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        rightColorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        rightColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        rightColorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
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
        addSubview(leftColorView)
        addSubview(rightColorView)
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
