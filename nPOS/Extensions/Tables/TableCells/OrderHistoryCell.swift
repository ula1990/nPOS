//
//  OrderHistoryCell.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 30/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

    lazy var orderIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var numberOfItemsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()

    fileprivate func setupViews(){

        orderIdLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        orderIdLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        orderIdLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height/2).isActive = true
        orderIdLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
        
        numberOfItemsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
        numberOfItemsLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true
        numberOfItemsLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height/2).isActive = true
        numberOfItemsLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
        
        
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height/2).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
        
        amountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height/2).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(orderIdLabel)
        addSubview(dateLabel)
        addSubview(amountLabel)
        addSubview(numberOfItemsLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDataInCell(order: Order){
        orderIdLabel.text = "Order # " + String(order.id!)
        numberOfItemsLabel.text = "Number Of Items: " + String(order.items!.count)
        dateLabel.text = "Timestamp: " + String(order.timestamp!)
        amountLabel.text = "Amount: " + String(order.totalPrice!) + "$"
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
