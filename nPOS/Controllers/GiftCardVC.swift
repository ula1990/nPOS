//
//  GiftCardVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class GiftCardVC: UIViewController {
    
    
    lazy var giftCardInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Uups..No Gift Cards "
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
//        label.backgroundColor = UIColor(named: "background")
        return label
    }()
    
    lazy var giftCardLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "giftcard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(giftCardLogo)
        view.addSubview(giftCardInfo)
        setupView()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    

}
