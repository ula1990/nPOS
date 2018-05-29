//
//  NewItemVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 29/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewItemVC: UIViewController {
    
    let categoryCellId = "categoryCellId"
    var categoryList: [Category] = []
    var categoriesShowing = false
    var categoriesWidthAnchor: NSLayoutConstraint?
    
    lazy var newItemView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var categoryColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add New Item"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var itemNameTF: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Name of the item",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var itemDescriptionTF: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Item Description",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var itemPriceTF: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Item Price",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var selectItemCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Category:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var  selectedCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17 )
        button.addTarget(self, action: #selector(handleSelectCategory), for: .touchUpInside)
        button.setTitle("Unknown", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.tintColor = UIColor.white.withAlphaComponent(0.8)
        button.backgroundColor = UIColor(named: "background")
        button.layer.cornerRadius = 2
        button.contentHorizontalAlignment = .right
        return button
        
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left:2, bottom: 2, right: 2)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ItemCategoryCell.self, forCellWithReuseIdentifier: categoryCellId)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.isScrollEnabled = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    
    lazy var itemPriceNetto: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Netto Price:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var itemPriceNettoResult: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    
    lazy var itemPriceTax: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tax:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    lazy var itemPriceTaxResult: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action:#selector(handleDismiss))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    fileprivate func setupView(){
        
        newItemView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newItemView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newItemView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        newItemView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        categoryCollectionView.leftAnchor.constraint(equalTo: newItemView.rightAnchor).isActive = true
        categoryCollectionView.centerYAnchor.constraint(equalTo: newItemView.centerYAnchor).isActive = true
        categoryCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        categoriesWidthAnchor = categoryCollectionView.widthAnchor.constraint(equalToConstant: 0)
        categoriesWidthAnchor?.isActive = true
        
        
        categoryColorView.topAnchor.constraint(equalTo: newItemView.topAnchor, constant: 2).isActive = true
        categoryColorView.bottomAnchor.constraint(equalTo: newItemView.bottomAnchor, constant: -2).isActive = true
        categoryColorView.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 2).isActive = true
        categoryColorView.widthAnchor.constraint(equalToConstant: 5).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: newItemView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        itemNameTF.centerXAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemNameTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        itemNameTF.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        itemNameTF.rightAnchor.constraint(equalTo: newItemView.rightAnchor, constant: -20).isActive = true
        itemNameTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemDescriptionTF.centerXAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemDescriptionTF.topAnchor.constraint(equalTo: itemNameTF.bottomAnchor, constant: 20).isActive = true
        itemDescriptionTF.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        itemDescriptionTF.rightAnchor.constraint(equalTo: newItemView.rightAnchor, constant: -20).isActive = true
        itemDescriptionTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemPriceTF.centerXAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemPriceTF.topAnchor.constraint(equalTo: itemDescriptionTF.bottomAnchor, constant: 20).isActive = true
        itemPriceTF.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        itemPriceTF.rightAnchor.constraint(equalTo: newItemView.rightAnchor, constant: -20).isActive = true
        itemPriceTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectItemCategory.topAnchor.constraint(equalTo: itemPriceTF.bottomAnchor, constant: 20).isActive = true
        selectItemCategory.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        selectItemCategory.rightAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        selectItemCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectedCategoryButton.topAnchor.constraint(equalTo: itemPriceTF.bottomAnchor, constant: 20).isActive = true
        selectedCategoryButton.leftAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        selectedCategoryButton.rightAnchor.constraint(equalTo:  newItemView.rightAnchor, constant: -20).isActive = true
        selectedCategoryButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemPriceNetto.topAnchor.constraint(equalTo: selectItemCategory.bottomAnchor, constant: 20).isActive = true
        itemPriceNetto.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        itemPriceNetto.rightAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemPriceNetto.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemPriceNettoResult.topAnchor.constraint(equalTo: selectItemCategory.bottomAnchor, constant: 20).isActive = true
        itemPriceNettoResult.leftAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemPriceNettoResult.rightAnchor.constraint(equalTo: newItemView.rightAnchor, constant: -20).isActive = true
        itemPriceNettoResult.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemPriceTax.topAnchor.constraint(equalTo: itemPriceNetto.bottomAnchor, constant: 20).isActive = true
        itemPriceTax.leftAnchor.constraint(equalTo: newItemView.leftAnchor, constant: 20).isActive = true
        itemPriceTax.rightAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemPriceTax.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        itemPriceTaxResult.topAnchor.constraint(equalTo: itemPriceNetto.bottomAnchor, constant: 20).isActive = true
        itemPriceTaxResult.leftAnchor.constraint(equalTo: newItemView.centerXAnchor).isActive = true
        itemPriceTaxResult.rightAnchor.constraint(equalTo: newItemView.rightAnchor, constant: -20).isActive = true
        itemPriceTaxResult.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.1)
        configureNavBar()
        view.addSubview(newItemView)
        view.addSubview(categoryCollectionView)
        newItemView.addSubview(categoryColorView)
        newItemView.addSubview(titleLabel)
        newItemView.addSubview(itemNameTF)
        newItemView.addSubview(itemDescriptionTF)
        newItemView.addSubview(itemPriceTF)
        newItemView.addSubview(selectItemCategory)
        newItemView.addSubview(selectedCategoryButton)
        newItemView.addSubview(itemPriceNetto)
        newItemView.addSubview(itemPriceNettoResult)
        newItemView.addSubview(itemPriceTax)
        newItemView.addSubview(itemPriceTaxResult)
        setupView()
        categoryList = temporaryCategoryArray()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.4)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
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
    
    @objc public func handleSelectCategory(){
        if (categoriesShowing){
            UIView.animate(withDuration: 0.3) {
                self.categoriesWidthAnchor?.isActive = false
                self.categoriesWidthAnchor = self.categoryCollectionView.widthAnchor.constraint(equalToConstant: 0)
                self.categoriesWidthAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.categoriesWidthAnchor?.isActive = false
                self.categoriesWidthAnchor = self.categoryCollectionView.widthAnchor.constraint(equalToConstant: 170)
                self.categoriesWidthAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (true) in
            }
        }
        categoriesShowing = !categoriesShowing
    }


}
