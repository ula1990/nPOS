//
//  GiftCardVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class GiftCardVC: UIViewController {
    
    let giftCardCellId = "giftCardCellId"
    var cards: [Item] = []
    var selectedCard: Item?
    
    
    lazy var addGiftCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var addGiftCardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Add New Gift Card"
        return label
    }()
    
    lazy var giftCardIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "new_giftcard")
        return image
    }()
    
    lazy var amountTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Amount",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var giftCardNameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Name of the Card",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var giftCardInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uups..No Gift Cards "
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var giftCardLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "giftcard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var  addGiftCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleAddGiftCard), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(named: "9")
        button.layer.cornerRadius = 2
        return button
        
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var infoTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "To create a new Gift card you need to put first, amount of the card in the text field from the left side of the screen and after that provide the name of the gift card,which staff can easily recognize."
        tv.textColor = UIColor.white.withAlphaComponent(0.8)
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.textAlignment = .left
        tv.backgroundColor = UIColor(named: "background")
        return tv
    }()
    
    
    lazy var giftCardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 1, right: 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GiftCardCell.self, forCellWithReuseIdentifier: giftCardCellId)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.isScrollEnabled = true
        view.isHidden = true
        return view
    }()

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action:#selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "Gift Cards"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    fileprivate func setupView(){
        
        addGiftCardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        addGiftCardView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        addGiftCardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        addGiftCardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        giftCardLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        giftCardLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        giftCardLogo.heightAnchor.constraint(equalToConstant: 250).isActive = true
        giftCardLogo.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        giftCardInfo.centerXAnchor.constraint(equalTo: giftCardLogo.centerXAnchor).isActive = true
        giftCardInfo.topAnchor.constraint(equalTo: giftCardLogo.bottomAnchor, constant: 20).isActive = true
        giftCardInfo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        giftCardCollectionView.topAnchor.constraint(equalTo: addGiftCardView.bottomAnchor, constant: 20).isActive = true
        giftCardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        giftCardCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        giftCardCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        addGiftCardLabel.leftAnchor.constraint(equalTo: addGiftCardView.leftAnchor, constant: 20).isActive = true
        addGiftCardLabel.topAnchor.constraint(equalTo: addGiftCardView.topAnchor, constant: 20).isActive = true
        addGiftCardLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addGiftCardLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        giftCardIcon.centerYAnchor.constraint(equalTo: addGiftCardLabel.centerYAnchor).isActive = true
        giftCardIcon.leftAnchor.constraint(equalTo: addGiftCardLabel.rightAnchor, constant: 20).isActive = true
        giftCardIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        giftCardIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        amountTextField.leftAnchor.constraint(equalTo: addGiftCardView.leftAnchor, constant: 20).isActive = true
        amountTextField.topAnchor.constraint(equalTo: addGiftCardLabel.bottomAnchor, constant: 20).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        amountTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        giftCardNameTextField.leftAnchor.constraint(equalTo: addGiftCardView.leftAnchor, constant: 20).isActive = true
        giftCardNameTextField.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20).isActive = true
        giftCardNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        giftCardNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addGiftCardButton.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor).isActive = true
        addGiftCardButton.leftAnchor.constraint(equalTo: amountTextField.rightAnchor, constant: 50).isActive = true
        addGiftCardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addGiftCardButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        seperatorView.centerXAnchor.constraint(equalTo: addGiftCardView.centerXAnchor).isActive = true
        seperatorView.centerYAnchor.constraint(equalTo: addGiftCardView.centerYAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: addGiftCardView.topAnchor, constant: 10).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: addGiftCardView.bottomAnchor, constant: -10).isActive = true
        seperatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: addGiftCardView.topAnchor, constant: 20).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: addGiftCardView.rightAnchor, constant: -20).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: seperatorView.leftAnchor, constant: 20).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        infoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5).isActive = true
        infoTextView.rightAnchor.constraint(equalTo: addGiftCardView.rightAnchor, constant: -20).isActive = true
        infoTextView.leftAnchor.constraint(equalTo: seperatorView.leftAnchor, constant: 20).isActive = true
        infoTextView.bottomAnchor.constraint(equalTo: addGiftCardView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        cards = temporaryGiftCardArray()
        checkData()
        view.addSubview(addGiftCardView)
        addGiftCardView.addSubview(addGiftCardLabel)
        addGiftCardView.addSubview(giftCardIcon)
        addGiftCardView.addSubview(amountTextField)
        addGiftCardView.addSubview(giftCardNameTextField)
        addGiftCardView.addSubview(addGiftCardButton)
        addGiftCardView.addSubview(seperatorView)
        addGiftCardView.addSubview(infoLabel)
        addGiftCardView.addSubview(infoTextView)
        
        view.addSubview(giftCardLogo)
        view.addSubview(giftCardInfo)
        view.addSubview(giftCardCollectionView)
        
        giftCardCollectionView.delegate = self
        giftCardCollectionView.dataSource = self
        setupView()
        configureNavBar()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        amountTextField.inputAccessoryView = toolBar
        giftCardNameTextField.inputAccessoryView = toolBar
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        amountTextField.delegate = self
        configureNavBar()
        checkData()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func checkData(){
        if cards.isEmpty == true {
            giftCardLogo.isHidden = false
            giftCardInfo.isHidden = false
        }else{
            giftCardCollectionView.isHidden = false
        }
    }
    
    @objc func finishedWithInput (){
        view.endEditing(true)
    }
    
    func temporaryGiftCardArray()->[Item]{
        var array: [Item] = []
        let item1 = Item(id: "1", name: "Platinum", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item2 = Item(id: "2", name: "Gold", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item3 = Item(id: "3", name: "Best Friend", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item4 = Item(id: "4", name: "Best Gift", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item5 = Item(id: "5", name: "Gift", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item6 = Item(id: "6", name: "Gift", imageName: "card", price: 100, vat: 0, desc: "Nice", category: 9)
        let item7 = Item(id: "7", name: "Gift", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item8 = Item(id: "8", name: "Gift", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item9 = Item(id: "9", name: "All in", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item10 = Item(id: "10", name: "Present", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item11 = Item(id: "11", name: "Gift", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item12 = Item(id: "12", name: "Gift", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item13 = Item(id: "13", name: "Gift", imageName: "card", price: 50, vat: 0, desc: "Nice", category: 9)
        let item14 = Item(id: "14", name: "Gift", imageName: "card", price: 20, vat: 0, desc: "Nice", category: 9)
        let item15 = Item(id: "15", name: "Gift", imageName: "card", price: 250, vat: 0, desc: "Nice", category: 9)
        let item16 = Item(id: "16", name: "Gift", imageName: "card", price: 40, vat: 0, desc: "Nice", category: 9)
        let item17 = Item(id: "17", name: "Gift", imageName: "card", price: 40, vat: 0, desc: "Nice", category: 9)
        let item18 = Item(id: "18", name: "Gift", imageName: "card", price: 40, vat: 0, desc: "Nice", category: 9)
        let item19 = Item(id: "19", name: "Gift", imageName: "card", price: 40, vat: 0, desc: "Nice", category: 9)
        
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
    

}
