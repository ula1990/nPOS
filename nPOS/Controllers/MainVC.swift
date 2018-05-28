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
    var totalAmountInfo: Double?
    
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
        label.text = "Table 5"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        label.backgroundColor = UIColor(named: "background")
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
        })
        giftCardObserver = NotificationCenter.default.addObserver(forName: .selectedGiftCard, object: nil, queue: OperationQueue.main, using: { (notification) in
            let giftCardVc = notification.object as! GiftCardVC
            self.itemInCart.append(giftCardVc.selectedCard!)
            self.cartTableView.reloadData()
            self.calculateTotal()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tableObserver = tableObserver{
            NotificationCenter.default.removeObserver(tableObserver)
        }
        if let giftCardObserver = giftCardObserver{
            NotificationCenter.default.removeObserver(giftCardObserver)
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
        tableLabel.widthAnchor.constraint(equalToConstant: cartView.frame.size.width/2)
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
        totalView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        totalView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20).isActive = true
        
        subTotalLabel.topAnchor.constraint(equalTo: totalView.topAnchor).isActive = true
        subTotalLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        subTotalLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subTotalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        taxLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor).isActive = true
        taxLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        taxLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        taxLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        totalLabel.topAnchor.constraint(equalTo: taxLabel.bottomAnchor).isActive = true
        totalLabel.leftAnchor.constraint(equalTo: totalView.leftAnchor, constant: 10).isActive = true
        totalLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        subTotalResultLabel.topAnchor.constraint(equalTo: totalView.topAnchor).isActive = true
        subTotalResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        subTotalResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        subTotalResultLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        taxResultLabel.topAnchor.constraint(equalTo: subTotalLabel.bottomAnchor).isActive = true
        taxResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        taxResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        taxResultLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        totalResultLabel.topAnchor.constraint(equalTo: taxLabel.bottomAnchor).isActive = true
        totalResultLabel.rightAnchor.constraint(equalTo: totalView.rightAnchor, constant: -10).isActive = true
        totalResultLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        totalResultLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
     //   itemCollectionView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        
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
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    
    func fetchUserAndSetupNavBarTitle(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
                
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImageUrl = dictionary["profileImageUrl"] as? String
                self.setupNavBarWithUser(user: user)
            }
        })
        
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            }catch let logoutError {
            print(logoutError)
            }
        let loginControlller = LoginController()
        loginControlller.mainController = self
        present(loginControlller, animated: true, completion: nil)
    }
    
    
    func temporaryArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Big Mac Burger", imageName: "burger1", price: 8.99, vat: 0.55, desc: "Nice")
        let item2 = Item(id: "2", name: "Chiken Burger", imageName: "burger2", price: 22.99, vat: 2.0, desc: "Nice")
        let item3 = Item(id: "3", name: "CheesBurger", imageName: "burger3", price: 44.99, vat: 4.65, desc: "Nice")
        let item4 = Item(id: "4", name: "El Maco Burger", imageName: "burger1", price: 2.99, vat: 0.20, desc: "Nice")
        let item5 = Item(id: "5", name: "Leeroy Burger", imageName: "burger2", price: 0.99, vat: 0.12, desc: "Nice")
        let item6 = Item(id: "6", name: "Ula Burger", imageName: "burger3", price: 35.99, vat: 3.40, desc: "Nice")
        let item7 = Item(id: "7", name: "New Burger", imageName: "burger2", price: 5.99, vat: 0.51, desc: "Nice")
        let item8 = Item(id: "8", name: "Old Burger", imageName: "burger1", price: 7.99, vat: 0.79, desc: "Nice")
        let item9 = Item(id: "9", name: "Big Mac Burger", imageName: "burger2", price: 21.99, vat: 2.14, desc: "Nice")
        let item10 = Item(id: "10", name: "Premium Burger", imageName: "burger3", price: 8.99, vat: 0.55, desc: "Nice")
        let item11 = Item(id: "11", name: "Double Burger", imageName: "burger1", price: 3.99, vat: 0.32, desc: "Nice")
        let item12 = Item(id: "12", name: "Mix Burger", imageName: "burger2", price: 9.99, vat: 0.99, desc: "Nice")
        let item13 = Item(id: "13", name: "Julia Burger", imageName: "burger3", price: 3.99, vat: 0.44, desc: "Nice")
        let item14 = Item(id: "14", name: "Big Mac Burger", imageName: "burger1", price: 9.99, vat: 0.99, desc: "Nice")
        let item15 = Item(id: "15", name: "Big Mac Burger", imageName: "burger3", price: 6.99, vat: 0.65, desc: "Nice")
        let item16 = Item(id: "16", name: "Big Mac Burger", imageName: "burger2", price: 2.99, vat: 0.23, desc: "Nice")
        let item17 = Item(id: "17", name: "Big Mac Burger", imageName: "burger3", price: 8.99, vat: 0.87, desc: "Nice")
        let item18 = Item(id: "18", name: "Boring Burger", imageName: "burger2", price: 8.99, vat: 0.87, desc: "Nice")
        let item19 = Item(id: "19", name: "Awesome Burger", imageName: "burger1", price: 8.99, vat: 0.87, desc: "Nice")
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        array.append(item9)
        array.append(item10)
        array.append(item11)
        array.append(item12)
        array.append(item13)
        array.append(item14)
        array.append(item15)
        array.append(item16)
        array.append(item17)
        array.append(item18)
        array.append(item19)
        return array
    }
    
    func temporaryCategoryArray()->[Category]{
        var array: [Category] = []
        let item1 = Category(id: 1, name: "Appetizers", color: UIColor(named: "1")!)
        let item2 = Category(id: 2, name: "Salads", color: UIColor(named: "2")!)
        let item3 = Category(id: 3, name: "Drinks", color: UIColor(named: "3")!)
        let item4 = Category(id: 4, name: "Spirits", color: UIColor(named: "4")!)
        let item5 = Category(id: 5, name: "Entrees", color: UIColor(named: "5")!)
        let item6 = Category(id: 6, name: "Desserts", color: UIColor(named: "6")!)
        let item7 = Category(id: 7, name: "Beers", color: UIColor(named: "7")!)
        let item8 = Category(id: 8, name: "Wine", color: UIColor(named: "8")!)

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

    func temporaryMenuArray()->[Menu]{
        var array: [Menu] = []
        let item1 = Menu(name: "Main", viewController: MainVC())
        let item2 = Menu(name: "Find Item", viewController: FindItemVC())
        let item3 = Menu(name: "Transactions", viewController: TransactionsVC())
        let item4 = Menu(name: "Gift Cards", viewController: GiftCardVC())
        let item5 = Menu(name: "Discounts", viewController: DiscountVC())
        let item6 = Menu(name: "Table", viewController: TableVC())
        let item7 = Menu(name: "Open Cashdrawer", viewController: CashDrawerVC())
        let item8 = Menu(name: "Support", viewController: SupportVC())

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
