//
//  DiscountVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class DiscountVC: UIViewController {
    
    let discountCellId = "discountCellId"
    var discounts: [Discount] = []
    var selectedDiscount: Double?
    var selectedDiscountPercent: Int?
    
    lazy var discountView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Available Discounts"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var titleLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "discount")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var discountsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left:1, bottom: 2, right: 1)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(DiscountCell.self, forCellWithReuseIdentifier: discountCellId)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.isScrollEnabled = true
        view.layer.cornerRadius = 2
        return view
    }()

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action:#selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @objc fileprivate func setupView(){
        discountView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        discountView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        discountView.widthAnchor.constraint(equalToConstant: 364).isActive = true
        discountView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: discountView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: discountView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLogo.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
        titleLogo.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        titleLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        titleLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        discountsCollectionView.centerXAnchor.constraint(equalTo: discountView.centerXAnchor).isActive = true
        discountsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20).isActive = true
        discountsCollectionView.leftAnchor.constraint(equalTo: discountView.leftAnchor,constant: 5).isActive = true
        discountsCollectionView.rightAnchor.constraint(equalTo: discountView.rightAnchor,constant: -5).isActive = true
        discountsCollectionView.bottomAnchor.constraint(equalTo: discountView.bottomAnchor,constant: -10).isActive = true

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(discountView)
        discountView.addSubview(titleLabel)
        discountView.addSubview(titleLogo)
        discountView.addSubview(discountsCollectionView)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.7)
        configureNavBar()
        setupView()
        discountsCollectionView.delegate = self
        discountsCollectionView.dataSource = self
        discounts = temporaryDiscountArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.7)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func temporaryDiscountArray()->[Discount]{
        var array: [Discount] = []
        let item1 = Discount(id: 1, name: "Premium", percentage: 30, rate: 0.7)
        let item2 = Discount(id: 2, name: "Gold", percentage: 25, rate: 0.75)
        let item3 = Discount(id: 3, name: "Stuff", percentage: 80, rate: 0.2)
        let item4 = Discount(id: 4, name: "Gift", percentage: 5, rate: 0.95)
        let item5 = Discount(id: 5, name: "10 Items", percentage: 20, rate: 0.8)
        let item6 = Discount(id: 6, name: "Loyalty", percentage: 35, rate: 0.65)
        let item7 = Discount(id: 7, name: "Premium", percentage: 30, rate: 0.7)
        let item8 = Discount(id: 8, name: "Old", percentage: 30, rate: 0.7)
        let item9 = Discount(id: 9, name: "Premium", percentage: 30, rate: 0.7)
        let item10 = Discount(id: 10, name: "Gold", percentage: 25, rate: 0.75)
        let item11 = Discount(id: 11, name: "Stuff", percentage: 80, rate: 0.2)
        let item12 = Discount(id: 12, name: "Gift", percentage: 5, rate: 0.95)
        let item13 = Discount(id: 13, name: "10 Items", percentage: 20, rate: 0.8)
        let item14 = Discount(id: 14, name: "Loyalty", percentage: 35, rate: 0.65)
        let item15 = Discount(id: 15, name: "Premium", percentage: 30, rate: 0.7)
        let item16 = Discount(id: 16, name: "Old", percentage: 30, rate: 0.7)

        
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
        
        return array
    }

}
