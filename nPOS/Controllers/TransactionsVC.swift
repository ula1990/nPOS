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
    let checkItemsCellId = "checkItemsCellId"
    var listOfOrders: [Order] = []
    var listOfItems: [Item] = []
    var checkWidthAnchor: NSLayoutConstraint?
    var checkTitleWidthAnchor: NSLayoutConstraint?
    var checkLogoWidthAnchor: NSLayoutConstraint?
    
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
    
    lazy var checkView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var checkTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Receipt"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check_logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var checkOrderNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Order #:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var checkSecondSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    
    lazy var checkTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Paid:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkTaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tax:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkTotalResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0-"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkTaxResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0-"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var checkItemsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CheckItemCell.self, forCellReuseIdentifier: checkItemsCellId)
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "background")
        return table
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var orderInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Information"
        return label
    }()
    
    lazy var orderTextInfo: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.textColor = UIColor.white.withAlphaComponent(0.8)
        text.font = UIFont.systemFont(ofSize: 17)
        text.text = "To create a new table  you need to put first, id of the table in the text field from the left side of the screen,provide the name of the table,which staff can easily recognize and after that select category of the table which will show amount of the places on the table"
        text.backgroundColor = UIColor(named: "background")
        return text
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
        listOfOrdersView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
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
        historyTableView.rightAnchor.constraint(equalTo: listOfOrdersView.rightAnchor, constant: -5).isActive = true
        historyTableView.leftAnchor.constraint(equalTo: listOfOrdersView.leftAnchor, constant: 5).isActive = true
        historyTableView.bottomAnchor.constraint(equalTo: listOfOrdersView.bottomAnchor, constant: -15).isActive = true
        historyTableView.centerXAnchor.constraint(equalTo: listOfOrdersView.centerXAnchor).isActive = true
        
        checkView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        checkView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        checkView.leftAnchor.constraint(equalTo: listOfOrdersView.rightAnchor,constant: 40).isActive = true
        checkWidthAnchor = checkView.widthAnchor.constraint(equalToConstant: 0)
        checkWidthAnchor?.isActive = true
        
        checkTitleLabel.topAnchor.constraint(equalTo: checkView.topAnchor).isActive = true
        checkTitleLabel.centerXAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        checkTitleWidthAnchor = checkTitleLabel.widthAnchor.constraint(equalToConstant: 0)
        checkTitleWidthAnchor?.isActive = true
        checkTitleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        checkLogo.leftAnchor.constraint(equalTo: checkTitleLabel.rightAnchor,constant: 10).isActive = true
        checkLogo.centerYAnchor.constraint(equalTo: checkTitleLabel.centerYAnchor).isActive = true
        checkLogoWidthAnchor = checkLogo.widthAnchor.constraint(equalToConstant: 0)
        checkLogoWidthAnchor?.isActive = true
        checkLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        checkOrderNumLabel.topAnchor.constraint(equalTo: checkTitleLabel.bottomAnchor, constant: 10).isActive = true
        checkOrderNumLabel.leftAnchor.constraint(equalTo: checkView.leftAnchor,constant: 10).isActive = true
        checkOrderNumLabel.rightAnchor.constraint(equalTo: checkView.rightAnchor).isActive = true
        checkOrderNumLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        checkDateLabel.topAnchor.constraint(equalTo: checkOrderNumLabel.bottomAnchor, constant: 10).isActive = true
        checkDateLabel.leftAnchor.constraint(equalTo: checkView.leftAnchor,constant: 10).isActive = true
        checkDateLabel.rightAnchor.constraint(equalTo: checkView.rightAnchor).isActive = true
        checkDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        checkSeperatorView.topAnchor.constraint(equalTo: checkDateLabel.bottomAnchor, constant: 15).isActive = true
        checkSeperatorView.rightAnchor.constraint(equalTo: checkView.rightAnchor, constant: -10).isActive = true
        checkSeperatorView.leftAnchor.constraint(equalTo: checkView.leftAnchor, constant: 10).isActive = true
        checkSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        checkSecondSeperatorView.bottomAnchor.constraint(equalTo: checkTaxLabel.topAnchor, constant: -15).isActive = true
        checkSecondSeperatorView.rightAnchor.constraint(equalTo: checkView.rightAnchor, constant: -10).isActive = true
        checkSecondSeperatorView.leftAnchor.constraint(equalTo: checkView.leftAnchor, constant: 10).isActive = true
        checkSecondSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        checkTaxLabel.bottomAnchor.constraint(equalTo: checkTotalLabel.topAnchor, constant: -10).isActive = true
        checkTaxLabel.leftAnchor.constraint(equalTo: checkView.leftAnchor,constant: 10).isActive = true
        checkTaxLabel.rightAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        checkTaxLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        checkTotalLabel.bottomAnchor.constraint(equalTo: checkView.bottomAnchor, constant: -20).isActive = true
        checkTotalLabel.leftAnchor.constraint(equalTo: checkView.leftAnchor,constant: 10).isActive = true
        checkTotalLabel.rightAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        checkTotalLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        checkTaxResultLabel.bottomAnchor.constraint(equalTo: checkTotalLabel.topAnchor, constant: -10).isActive = true
        checkTaxResultLabel.rightAnchor.constraint(equalTo: checkView.rightAnchor,constant: -10).isActive = true
        checkTaxResultLabel.leftAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        checkTaxResultLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        checkTotalResultLabel.bottomAnchor.constraint(equalTo: checkView.bottomAnchor, constant: -20).isActive = true
        checkTotalResultLabel.rightAnchor.constraint(equalTo: checkView.rightAnchor,constant: -10).isActive = true
        checkTotalResultLabel.leftAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        checkTotalResultLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    
        checkItemsTableView.topAnchor.constraint(equalTo: checkSeperatorView.bottomAnchor, constant: 15).isActive = true
        checkItemsTableView.rightAnchor.constraint(equalTo: checkView.rightAnchor, constant: -5).isActive = true
        checkItemsTableView.leftAnchor.constraint(equalTo: checkView.leftAnchor, constant: 5).isActive = true
        checkItemsTableView.bottomAnchor.constraint(equalTo: checkSecondSeperatorView.topAnchor, constant: -15).isActive = true
        checkItemsTableView.centerXAnchor.constraint(equalTo: checkView.centerXAnchor).isActive = true
        
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        infoView.leftAnchor.constraint(equalTo: checkView.rightAnchor,constant: 40).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        
        orderInfoLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 20).isActive = true
        orderInfoLabel.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -20).isActive = true
        orderInfoLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        orderInfoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        orderTextInfo.topAnchor.constraint(equalTo: orderInfoLabel.bottomAnchor, constant: 5).isActive = true
        orderTextInfo.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -20).isActive = true
        orderTextInfo.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        orderTextInfo.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listOfOrdersView)
        view.addSubview(checkView)
        view.addSubview(infoView)
        checkView.addSubview(checkTitleLabel)
        checkView.addSubview(checkLogo)
        checkView.addSubview(checkOrderNumLabel)
        checkView.addSubview(checkDateLabel)
        checkView.addSubview(checkSeperatorView)
        checkView.addSubview(checkTotalLabel)
        checkView.addSubview(checkTaxLabel)
        checkView.addSubview(checkTotalResultLabel)
        checkView.addSubview(checkTaxResultLabel)
        checkView.addSubview(checkSecondSeperatorView)
        checkView.addSubview(checkItemsTableView)
        infoView.addSubview(orderInfoLabel)
        infoView.addSubview(orderTextInfo)
        
        listOfOrdersView.addSubview(orderHistoryLabel)
        listOfOrdersView.addSubview(orderLogo)
        listOfOrdersView.addSubview(seperatorView)
        listOfOrdersView.addSubview(historyTableView)
        setupView()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        configureNavBar()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        checkItemsTableView.delegate = self
        checkItemsTableView.dataSource = self
        listOfOrders = temporaryOrderListArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.checkWidthAnchor?.isActive = false
            self.checkLogoWidthAnchor?.isActive = false
            self.checkTitleWidthAnchor?.isActive = false
            self.checkWidthAnchor = self.checkView.widthAnchor.constraint(equalToConstant: 0)
            self.checkLogoWidthAnchor = self.checkLogo.widthAnchor.constraint(equalToConstant: 0)
            self.checkTitleWidthAnchor = self.checkTitleLabel.widthAnchor.constraint(equalToConstant: 0)
            
            self.checkWidthAnchor?.isActive = true
            self.checkLogoWidthAnchor?.isActive = true
            self.checkTitleWidthAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc public func temporaryOrderListArray()->[Order]{
        var array: [Order] = []
        let item1 = Order(id: "43773499", timestamp: "26.05.18", taxes: 30.0, totalPrice: 144.80, items: temporaryDesertsArray())
        let item2 = Order(id: "35466577", timestamp: "29.05.18", taxes: 20.0, totalPrice: 44.80, items: temporaryReceiptArray())
        let item3 = Order(id: "35464677", timestamp: "30.05.18", taxes: 40.0, totalPrice: 546.80, items: temporaryReceiptArray())
        let item4 = Order(id: "46565757", timestamp: "28.05.18", taxes: 50.0, totalPrice: 347.80, items: temporaryDesertsArray())
        let item5 = Order(id: "56575766", timestamp: "16.05.18", taxes: 60.0, totalPrice: 144.80, items: temporaryReceiptArray())
        let item6 = Order(id: "56575777", timestamp: "28.05.18", taxes: 70.0, totalPrice: 247.80, items: temporaryDesertsArray())
        let item7 = Order(id: "65757578", timestamp: "40.05.18", taxes: 80.0, totalPrice: 244.80, items: temporaryReceiptArray())
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
    
    @objc public func temporaryReceiptArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Coca Cola", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice", category: 6)
        let item2 = Item(id: "2", name: "Milk", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice", category: 6)
        let item3 = Item(id: "3", name: "Jucie", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice", category: 6)
        let item4 = Item(id: "4", name: "Burder", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice", category: 6)
        let item5 = Item(id: "5", name: "Sundae", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice", category: 6)
    
        
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)

        
        return array
    }
    
    @objc public func updateCheckView(order: Order){
        checkOrderNumLabel.text = "Order #:" + order.id!
        checkDateLabel.text = "Date:" + order.timestamp!
        checkTotalResultLabel.text = "-$" + String(order.totalPrice!)
        checkTaxResultLabel.text = "-$" + String(order.taxes!)
        listOfItems.removeAll()
        listOfItems = order.items!
        checkItemsTableView.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.checkWidthAnchor?.isActive = false
            self.checkLogoWidthAnchor?.isActive = false
            self.checkTitleWidthAnchor?.isActive = false
            self.checkWidthAnchor = self.checkView.widthAnchor.constraint(equalToConstant: 300)
            self.checkLogoWidthAnchor = self.checkLogo.widthAnchor.constraint(equalToConstant: 40)
            self.checkTitleWidthAnchor = self.checkTitleLabel.widthAnchor.constraint(equalToConstant: 100)
            
            self.checkWidthAnchor?.isActive = true
            self.checkLogoWidthAnchor?.isActive = true
            self.checkTitleWidthAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
        
    }
}
