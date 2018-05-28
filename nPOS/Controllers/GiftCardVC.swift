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
    var cards: [GiftCard] = []
    
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
        giftCardLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        giftCardLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        giftCardLogo.heightAnchor.constraint(equalToConstant: 250).isActive = true
        giftCardLogo.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        giftCardInfo.centerXAnchor.constraint(equalTo: giftCardLogo.centerXAnchor).isActive = true
        giftCardInfo.topAnchor.constraint(equalTo: giftCardLogo.bottomAnchor, constant: 20).isActive = true
        giftCardInfo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        giftCardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        giftCardCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        giftCardCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        giftCardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        giftCardCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        giftCardCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        cards = temporaryGiftCardArray()
        checkData()
        view.addSubview(giftCardLogo)
        view.addSubview(giftCardInfo)
        view.addSubview(giftCardCollectionView)
        giftCardCollectionView.delegate = self
        giftCardCollectionView.dataSource = self
        setupView()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
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
    
    func temporaryGiftCardArray()->[GiftCard]{
        var array: [GiftCard] = []
        let item1 = GiftCard(id: "1", name: "Daily Discount", imageName: "card", percentage: 15)
        let item2 = GiftCard(id: "1", name: "Stuff", imageName: "card", percentage: 10)
        let item3 = GiftCard(id: "1", name: "Lunch", imageName: "card1", percentage: 25)
        let item4 = GiftCard(id: "1", name: "Loyalty", imageName: "card", percentage: 40)
        let item5 = GiftCard(id: "1", name: "Spring", imageName: "card1", percentage: 45)
        let item6 = GiftCard(id: "1", name: "Winter", imageName: "card1", percentage: 6)
        let item7 = GiftCard(id: "1", name: "Summer", imageName: "card", percentage: 2)
        let item8 = GiftCard(id: "1", name: "Weekend", imageName: "card", percentage: 73)
        let item9 = GiftCard(id: "1", name: "Monday", imageName: "card", percentage: 7)
        let item10 = GiftCard(id: "1", name: "Monday", imageName: "card1", percentage: 7)
        let item11 = GiftCard(id: "1", name: "Monday", imageName: "card", percentage: 7)
        let item12 = GiftCard(id: "1", name: "Monday", imageName: "card1", percentage: 7)
        let item13 = GiftCard(id: "1", name: "Monday", imageName: "card1", percentage: 7)
        let item14 = GiftCard(id: "1", name: "Monday", imageName: "card", percentage: 7)
        
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
        
        return array
    }
    

}
