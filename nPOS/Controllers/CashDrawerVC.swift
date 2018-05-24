//
//  CashDrawerVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CashDrawerVC: UIViewController {
    
    lazy var cashDrawerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cash Drawer was opened"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var cashDrawerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cashdrawer")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dismiss"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.tintColor = UIColor.white
//        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    fileprivate func setupView() {
        cashDrawerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cashDrawerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cashDrawerView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        cashDrawerView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: cashDrawerView.centerXAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: cashDrawerLogo.topAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cashDrawerLogo.centerXAnchor.constraint(equalTo: cashDrawerView.centerXAnchor).isActive = true
        cashDrawerLogo.centerYAnchor.constraint(equalTo: cashDrawerView.centerYAnchor).isActive = true
        cashDrawerLogo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        cashDrawerLogo.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        dismissButton.centerXAnchor.constraint(equalTo: cashDrawerView.centerXAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: cashDrawerLogo.bottomAnchor,constant: -5).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.addSubview(cashDrawerView)
        cashDrawerView.addSubview(cashDrawerLogo)
        cashDrawerView.addSubview(dismissButton)
        cashDrawerView.addSubview(infoLabel)
        configureNavBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    

}
