//
//  MainVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainVC: UIViewController {
    
    let menuCellId = "menuCellId"
    let categoryCellId = "categoryCellId"
    let cartCellId = "cartCellId"
    let itemCellId = "ItemCellId"
    var tableObserver: NSObjectProtocol?
    var giftCardObserver: NSObjectProtocol?
    var addItemObserver: NSObjectProtocol?
    var addDiscountObserver: NSObjectProtocol?
    var totalAmountInfo: Double?
    var discountLabelHigthAnchor: NSLayoutConstraint?
    var discountResultLabelHigthAnchor: NSLayoutConstraint?
    var totalViewHightAnchor: NSLayoutConstraint?
    var discountsShowing = false
    
    var menuBar: [Menu] = []
    var items: [Item] = []
    var itemInCart: [Item] = []
    var categoryList: [Category] = []
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
    }
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
        view.backgroundColor = UIColor(named: "background")
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        view.backgroundColor = UIColor(named: "background")
        view.isScrollEnabled = true
        return view
    }()

    lazy var cartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cart"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var tableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Table #"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor(named: "background")
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    lazy var cartLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cart")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var seperatorCart: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var counterOfItemsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        label.layer.borderWidth = 1
        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var cartTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CartCell.self, forCellReuseIdentifier: cartCellId)
        table.separatorStyle = .none
        table.backgroundColor = UIColor(named: "background")
        return table
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var totalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Discount:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var discountResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    lazy var subTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtotal:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var subTotalResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    lazy var taxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tax:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var taxResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    lazy var totalResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    lazy var  clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor(named: "background")
        button.setTitle("Clear", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
        
    }()
    
    lazy var  chargeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor(named: "chargeButton")
        button.setTitle("Pay", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handlePay), for: .touchUpInside)
        return button
        
    }()
    
    lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ItemCell.self, forCellWithReuseIdentifier: itemCellId)
        view.backgroundColor = UIColor(named: "background")
        view.isScrollEnabled = true
        return view
    }()

   
    fileprivate func addAllElements() {
        view.backgroundColor = UIColor(named: "darkBackground")
        view.addSubview(categoryCollectionView)
        view.addSubview(cartView)
        view.addSubview(itemCollectionView)
        view.addSubview(menuCollectionView)
        cartView.addSubview(cartLabel)
        cartView.addSubview(tableLabel)
        cartView.addSubview(cartLogo)
        cartView.addSubview(seperatorCart)
        cartView.addSubview(counterOfItemsLabel)
        cartView.addSubview(chargeButton)
        cartView.addSubview(cartTableView)
        cartView.addSubview(seperatorView)
        cartView.addSubview(clearButton)
        cartView.addSubview(totalView)
        totalView.addSubview(discountLabel)
        totalView.addSubview(discountResultLabel)
        totalView.addSubview(subTotalLabel)
        totalView.addSubview(taxLabel)
        totalView.addSubview(totalLabel)
        totalView.addSubview(subTotalResultLabel)
        totalView.addSubview(taxResultLabel)
        totalView.addSubview(totalResultLabel)
    }
    
    fileprivate func addData() {
        items = temporaryArray()
        categoryList = temporaryCategoryArray()
        menuBar = temporaryMenuArray()
    }
    
    fileprivate func connectCollectionsTables() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        cartTableView.delegate = self
        cartTableView.dataSource = self
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"signout"), style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POS 1", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        addData()
        configureNavBar()
        addAllElements()
        setupView()
        connectCollectionsTables()
        UIApplication.shared.statusBarStyle = .lightContent
        tableObserver = NotificationCenter.default.addObserver(forName: .selectedTable, object: nil, queue: OperationQueue.main, using: { (notification) in
            let tableVc = notification.object as! TableVC
            self.tableLabel.text = tableVc.selectedTable
            self.handleClear()
        })
        giftCardObserver = NotificationCenter.default.addObserver(forName: .selectedGiftCard, object: nil, queue: OperationQueue.main, using: { (notification) in
            let giftCardVc = notification.object as! GiftCardVC
            self.itemInCart.append(giftCardVc.selectedCard!)
            self.cartTableView.reloadData()
            self.calculateTotal()
        })
        
        addItemObserver = NotificationCenter.default.addObserver(forName: .addItem, object: nil, queue: OperationQueue.main, using: { (notification) in
            let addItemVC = notification.object as! NewItemVC
            self.addCreatedItem(id: "1", name: addItemVC.itemNameTF.text!, imageName: "None", price: addItemVC.nettoAmount!, vat: addItemVC.taxAmount!, desc: addItemVC.itemDescriptionTF.text!, category: addItemVC.categoryId!)
            self.itemCollectionView.reloadData()

        })
        
        addDiscountObserver = NotificationCenter.default.addObserver(forName: .addDiscountToCart, object: nil, queue: OperationQueue.main, using: { (notification) in
            let addDiscountVC = notification.object as! DiscountVC
            if self.itemInCart.isEmpty == true{
                Alert.showBasic(title: "Cart Empty", msg: "Please first add items in the cart", vc: self)
            }else{
            self.discountLabel.text = "Discount(" + String(addDiscountVC.selectedDiscountPercent!) + "%)"
            self.subTotalResultLabel.text = "$" + String(round(Double(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +))*Double(addDiscountVC.selectedDiscount!)*100)/100)
            self.taxResultLabel.text = "$" +  String(round((Double(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +))*addDiscountVC.selectedDiscount!)*100)/100)
            self.totalResultLabel.text = "$" +  String(round((Double(Double(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +)) + Double(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +)))*addDiscountVC.selectedDiscount!)*100)/100)
            self.discountResultLabel.text = "$" +  String(round((Double(Double(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +)) + Double(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +)))*Double(1 - addDiscountVC.selectedDiscount!))*100)/100)
                UIView.animate(withDuration: 0.3, animations: {
                    self.discountResultLabelHigthAnchor?.isActive = false
                    self.discountLabelHigthAnchor?.isActive = false
                    self.totalViewHightAnchor?.isActive = false
                    self.discountLabelHigthAnchor = self.discountLabel.heightAnchor.constraint(equalToConstant: 40)
                    self.totalViewHightAnchor = self.totalView.heightAnchor.constraint(equalToConstant: 160)
                    self.discountResultLabelHigthAnchor = self.discountResultLabel.heightAnchor.constraint(equalToConstant: 40)
                    self.discountResultLabelHigthAnchor?.isActive = true
                    self.discountLabelHigthAnchor?.isActive = true
                    self.totalViewHightAnchor?.isActive = true
                    self.view.layoutIfNeeded()
                })
            }
            })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tableObserver = tableObserver{
            NotificationCenter.default.removeObserver(tableObserver)
        }
        if let giftCardObserver = giftCardObserver{
            NotificationCenter.default.removeObserver(giftCardObserver)
        }
        if let addItemObserver = addItemObserver{
            NotificationCenter.default.removeObserver(addItemObserver)
        }
        
    }
    
    fileprivate func setupView(){
        
        cartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        cartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        cartView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        cartView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5).isActive = true
        
        cartLabel.topAnchor.constraint(equalTo: cartView.topAnchor).isActive = true
        cartLabel.rightAnchor.constraint(equalTo: cartView.rightAnchor, constant: -10).isActive = true
        cartLabel.widthAnchor.constraint(equalToConstant: cartView.frame.size.width/2)
        cartLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        tableLabel.topAnchor.constraint(equalTo: cartView.topAnchor).isActive = true
        tableLabel.leftAnchor.constraint(equalTo: cartView.leftAnchor, constant: 10).isActive = true
        tableLabel.rightAnchor.constraint(equalTo: cartLogo.leftAnchor, constant: -1).isActive = true
        tableLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        cartLogo.centerXAnchor.constraint(equalTo: cartView.centerXAnchor).isActive = true
        cartLogo.centerYAnchor.constraint(equalTo: cartLabel.centerYAnchor).isActive = true
        cartLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cartLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        counterOfItemsLabel.topAnchor.constraint(equalTo: cartLogo.topAnchor).isActive = true
        counterOfItemsLabel.leftAnchor.constraint(equalTo: cartLogo.rightAnchor).isActive = true
        counterOfItemsLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        counterOfItemsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        seperatorCart.topAnchor.constraint(equalTo: cartLogo.bottomAnchor, constant: 15).isActive = true
        seperatorCart.rightAnchor.constraint(equalTo: cartView.rightAnchor, constant: -10).isActive = true
        seperatorCart.leftAnchor.constraint(equalTo: cartView.leftAnchor, constant: 10).isActive = true
        seperatorCart.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        cartTableView.topAnchor.constraint(equalTo: cartLabel.bottomAnchor, constant: 20).isActive = true
        cartTableView.centerXAnchor.constraint(equalTo: cartView.centerXAnchor).isActive = true
        cartTableView.widthAnchor.constraint(equalTo: cartView.widthAnchor).isActive = true
        cartTableView.bottomAnchor.constraint(equalTo: totalView.topAnchor, constant: -30).isActive = true
        
        seperatorView.topAnchor.constraint(equalTo: cartTableView.bottomAnchor, constant: 15).isActive = true
        seperatorView.rightAnchor.constraint(equalTo: cartView.rightAnchor, constant: -10).isActive = true
        seperatorView.leftAnchor.constraint(equalTo: cartView.leftAnchor, constant: 10).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        totalView.centerXAnchor.constraint(equalTo: cartView.centerXAnchor).isActive = true
        totalView.widthAnchor.constraint(equalTo: cartView.widthAnchor).isActive = true
        totalView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20).isActive = true
        totalViewHightAnchor = totalView.heightAnchor.constraint(equalToConstant: 120)
        totalViewHightAnchor?.isActive = true
        
        discountLabel.bottomAnchor.constraint(equalTo: subTotalLabel.topAnchor).isActive = true
        discountLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        discountLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        discountLabelHigthAnchor =  discountLabel.heightAnchor.constraint(equalToConstant: 0)
        discountLabelHigthAnchor?.isActive = true
        
        discountResultLabel.bottomAnchor.constraint(equalTo: subTotalLabel.topAnchor).isActive = true
        discountResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        discountResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        discountResultLabelHigthAnchor = discountResultLabel.heightAnchor.constraint(equalToConstant: 0)
        discountResultLabelHigthAnchor?.isActive = true
        
        subTotalLabel.bottomAnchor.constraint(equalTo: taxLabel.topAnchor).isActive = true
        subTotalLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        subTotalLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subTotalLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        taxLabel.bottomAnchor.constraint(equalTo: totalLabel.topAnchor).isActive = true
        taxLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        taxLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        taxLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        totalLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor).isActive = true
        totalLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        totalLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        subTotalResultLabel.bottomAnchor.constraint(equalTo: taxResultLabel.topAnchor).isActive = true
        subTotalResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        subTotalResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subTotalResultLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        taxResultLabel.bottomAnchor.constraint(equalTo: totalResultLabel.topAnchor).isActive = true
        taxResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        taxResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        taxResultLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        totalResultLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor).isActive = true
        totalResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        totalResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalResultLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        clearButton.bottomAnchor.constraint(equalTo: chargeButton.topAnchor).isActive = true
        clearButton.centerXAnchor.constraint(equalTo: cartView.centerXAnchor).isActive = true
        clearButton.leftAnchor.constraint(equalTo: cartView.leftAnchor).isActive = true
        clearButton.rightAnchor.constraint(equalTo: cartView.rightAnchor).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        chargeButton.bottomAnchor.constraint(equalTo: cartView.bottomAnchor).isActive = true
        chargeButton.centerXAnchor.constraint(equalTo: cartView.centerXAnchor).isActive = true
        chargeButton.leftAnchor.constraint(equalTo: cartView.leftAnchor).isActive = true
        chargeButton.rightAnchor.constraint(equalTo: cartView.rightAnchor).isActive = true
        chargeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        categoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 262).isActive = true
        categoryCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        categoryCollectionView.rightAnchor.constraint(equalTo: cartView.leftAnchor,constant: -20).isActive = true
        
        itemCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant:5).isActive = true
        itemCollectionView.bottomAnchor.constraint(equalTo: menuCollectionView.topAnchor, constant: -5).isActive = true
        itemCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        itemCollectionView.rightAnchor.constraint(equalTo: cartView.leftAnchor, constant: -20).isActive = true
        
        menuCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        menuCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: cartView.leftAnchor, constant: -20).isActive = true
        
        
     
    }
    
    @objc func handlePay(){
        totalAmountInfo = Double(self.itemInCart.compactMap({ Double($0.vat!) }).reduce(0, +)) + Double(self.itemInCart.compactMap({ Double($0.price!) }).reduce(0, +))
        NotificationCenter.default.post(name: .totalAmount, object: self)
        let payVC = UINavigationController(rootViewController: PayVC())
        payVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(payVC, animated: true, completion: nil)
    }
    
    @objc func handleClear(){
        itemInCart.removeAll()
        cartTableView.reloadData()
        counterOfItemsLabel.text = "0"
        totalResultLabel.text = "$0"
        taxResultLabel.text = totalResultLabel.text
        subTotalResultLabel.text = totalResultLabel.text
        discountResultLabel.text = totalResultLabel.text
        discountLabel.text = "Discount"
        discountsShowing = false
            UIView.animate(withDuration: 0.3) {
                self.discountResultLabelHigthAnchor?.isActive = false
                self.discountLabelHigthAnchor?.isActive = false
                self.totalViewHightAnchor?.isActive = false
                self.discountLabelHigthAnchor = self.discountLabel.heightAnchor.constraint(equalToConstant: 0)
                self.totalViewHightAnchor = self.totalView.heightAnchor.constraint(equalToConstant: 120)
                self.discountResultLabelHigthAnchor = self.discountResultLabel.heightAnchor.constraint(equalToConstant: 0)
                self.discountResultLabelHigthAnchor?.isActive = true
                self.discountLabelHigthAnchor?.isActive = true
                self.totalViewHightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
       
    }

    func setupNavBarWithUser(user: User){
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 17.5
        profileImageView.clipsToBounds = true
        profileImageView.tintColor = UIColor(named: "background")
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(named: "background")?.cgColor
        if let profileImgageUrl = user.profileImageUrl {
            profileImageView.loadimagesUisingCacheWithUrlString(urlString: profileImgageUrl)
        }
        
        containerView.addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let nameLabel = UILabel()
        containerView.addSubview(nameLabel)
        nameLabel.text = user.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
    }
    
    @objc fileprivate func hideShowDiscounts(){
    if (discountsShowing){
    UIView.animate(withDuration: 0.3) {
        self.discountResultLabelHigthAnchor?.isActive = false
        self.discountLabelHigthAnchor?.isActive = false
        self.totalViewHightAnchor?.isActive = false
        self.discountLabelHigthAnchor = self.discountLabel.heightAnchor.constraint(equalToConstant: 0)
        self.totalViewHightAnchor = self.totalView.heightAnchor.constraint(equalToConstant: 120)
        self.discountResultLabelHigthAnchor = self.discountResultLabel.heightAnchor.constraint(equalToConstant: 0)
        self.discountResultLabelHigthAnchor?.isActive = true
        self.discountLabelHigthAnchor?.isActive = true
        self.totalViewHightAnchor?.isActive = true
        self.view.layoutIfNeeded()
    }
    }else{
    UIView.animate(withDuration: 0.3, animations: {
        self.discountResultLabelHigthAnchor?.isActive = false
        self.discountLabelHigthAnchor?.isActive = false
        self.totalViewHightAnchor?.isActive = false
        self.discountLabelHigthAnchor = self.discountLabel.heightAnchor.constraint(equalToConstant: 40)
        self.totalViewHightAnchor = self.totalView.heightAnchor.constraint(equalToConstant: 160)
        self.discountResultLabelHigthAnchor = self.discountResultLabel.heightAnchor.constraint(equalToConstant: 40)
        self.discountResultLabelHigthAnchor?.isActive = true
        self.discountLabelHigthAnchor?.isActive = true
        self.totalViewHightAnchor?.isActive = true
        self.view.layoutIfNeeded()
    }) { (true) in
    }
    }
    discountsShowing = !discountsShowing
    
    }

}
