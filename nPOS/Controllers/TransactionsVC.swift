//
//  TransactionsVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TransactionsVC: UIViewController {
    
    let historyCellId = "historyCellId"
    var listOfOrders: [Order] = []
    
    lazy var listOfOrdersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var orderHistoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orders History"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var orderLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "order_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var historyTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(OrderHistoryCell.self, forCellReuseIdentifier: historyCellId)
//        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "background")
        return table
    }()

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action:#selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "Orders"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc fileprivate func setupView(){
    
        listOfOrdersView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        listOfOrdersView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        listOfOrdersView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        listOfOrdersView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        
        orderHistoryLabel.topAnchor.constraint(equalTo: listOfOrdersView.topAnchor).isActive = true
        orderHistoryLabel.centerXAnchor.constraint(equalTo: listOfOrdersView.centerXAnchor).isActive = true
        orderHistoryLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        orderHistoryLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        orderLogo.leftAnchor.constraint(equalTo: orderHistoryLabel.rightAnchor,constant: 10).isActive = true
        orderLogo.centerYAnchor.constraint(equalTo: orderHistoryLabel.centerYAnchor).isActive = true
        orderLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        orderLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        seperatorView.topAnchor.constraint(equalTo: orderHistoryLabel.bottomAnchor, constant: 15).isActive = true
        seperatorView.rightAnchor.constraint(equalTo: listOfOrdersView.rightAnchor, constant: -10).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: listOfOrdersView.leftAnchor, constant: 10).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        historyTableView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 15).isActive = true
        historyTableView.rightAnchor.constraint(equalTo: listOfOrdersView.rightAnchor, constant: -20).isActive = true
        historyTableView.leftAnchor.constraint(equalTo: listOfOrdersView.leftAnchor, constant: 20).isActive = true
        historyTableView.bottomAnchor.constraint(equalTo: listOfOrdersView.bottomAnchor, constant: -15).isActive = true
        historyTableView.centerXAnchor.constraint(equalTo: listOfOrdersView.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listOfOrdersView)
        listOfOrdersView.addSubview(orderHistoryLabel)
        listOfOrdersView.addSubview(orderLogo)
        listOfOrdersView.addSubview(seperatorView)
        listOfOrdersView.addSubview(historyTableView)
        setupView()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        configureNavBar()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        listOfOrders = temporaryOrderListArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func temporaryOrderListArray()->[Order]{
        var array: [Order] = []
        let item1 = Order(id: "43773499", timestamp: "26.05.18", taxes: 30.0, totalPrice: 144.80, items: temporaryDesertsArray())
        let item2 = Order(id: "35466577", timestamp: "29.05.18", taxes: 20.0, totalPrice: 44.80, items: temporaryDesertsArray())
        let item3 = Order(id: "35464677", timestamp: "30.05.18", taxes: 40.0, totalPrice: 546.80, items: temporaryDesertsArray())
        let item4 = Order(id: "46565757", timestamp: "28.05.18", taxes: 50.0, totalPrice: 347.80, items: temporaryDesertsArray())
        let item5 = Order(id: "56575766", timestamp: "16.05.18", taxes: 60.0, totalPrice: 144.80, items: temporaryDesertsArray())
        let item6 = Order(id: "56575777", timestamp: "28.05.18", taxes: 70.0, totalPrice: 247.80, items: temporaryDesertsArray())
        let item7 = Order(id: "65757578", timestamp: "40.05.18", taxes: 80.0, totalPrice: 244.80, items: temporaryDesertsArray())
        let item8 = Order(id: "05664643", timestamp: "26.05.18", taxes: 90.0, totalPrice: 934.80, items: temporaryDesertsArray())
        
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        
        return array
    }
    
    @objc public func temporaryDesertsArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Ice cream", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 6)
        let item2 = Item(id: "2", name: "Cheesecake", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 6)
        let item3 = Item(id: "3", name: "Waffle", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 6)
        let item4 = Item(id: "4", name: "Custard", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 6)
        let item5 = Item(id: "5", name: "Sundae", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 6)
        let item6 = Item(id: "6", name: "Apple Pie", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice", category:6)
        let item7 = Item(id: "7", name: "Sorbet", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice", category: 6)
        let item8 = Item(id: "8", name: "Tiramisu", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice", category: 6)
        
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        
        return array
    }
}
