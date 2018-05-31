//
//  PayVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 28/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class PayVC: UIViewController {
    
    var totalAmountObserver: NSObjectProtocol?
    
    lazy var payView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select method of payment:"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var cashPaymentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var cashPaymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cash"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cash"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var cardPaymentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var cardPaymentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Card"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "creditcard"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    lazy var totalPayment: UIButton = {
        let button = UIButton()
        button.backgroundColor =  UIColor(named: "chargeButton")
        button.setTitle("Total Amount: $0", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    
    

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }

    fileprivate func setupView(){
        payView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        payView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        payView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: payView.topAnchor,constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: payView.centerXAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: payView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: payView.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        cardPaymentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        cardPaymentView.leftAnchor.constraint(equalTo: payView.leftAnchor, constant: 20).isActive = true
        cardPaymentView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        cardPaymentView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        cardPaymentLabel.topAnchor.constraint(equalTo: cardPaymentView.topAnchor,constant: 5).isActive = true
        cardPaymentLabel.centerXAnchor.constraint(equalTo: cardPaymentView.centerXAnchor).isActive = true
        cardPaymentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cardPaymentLabel.leftAnchor.constraint(equalTo: cardPaymentView.leftAnchor, constant: 20).isActive = true
        cardPaymentLabel.rightAnchor.constraint(equalTo: cardPaymentView.rightAnchor, constant: -20).isActive = true
        
        cardButton.centerYAnchor.constraint(equalTo: cardPaymentView.centerYAnchor).isActive = true
        cardButton.centerXAnchor.constraint(equalTo: cardPaymentView.centerXAnchor).isActive = true
        cardButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cardButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        cashPaymentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        cashPaymentView.rightAnchor.constraint(equalTo: payView.rightAnchor, constant: -20).isActive = true
        cashPaymentView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        cashPaymentView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        cashPaymentLabel.topAnchor.constraint(equalTo: cashPaymentView.topAnchor,constant: 5).isActive = true
        cashPaymentLabel.centerXAnchor.constraint(equalTo: cashPaymentView.centerXAnchor).isActive = true
        cashPaymentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cashPaymentLabel.leftAnchor.constraint(equalTo: cashPaymentView.leftAnchor, constant: 20).isActive = true
        cashPaymentLabel.rightAnchor.constraint(equalTo: cashPaymentView.rightAnchor, constant: -20).isActive = true
        
        cashButton.centerYAnchor.constraint(equalTo: cashPaymentView.centerYAnchor).isActive = true
        cashButton.centerXAnchor.constraint(equalTo: cashPaymentView.centerXAnchor).isActive = true
        cashButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        cashButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        totalPayment.bottomAnchor.constraint(equalTo: payView.bottomAnchor,constant: -10).isActive = true
        totalPayment.centerXAnchor.constraint(equalTo: payView.centerXAnchor).isActive = true
        totalPayment.heightAnchor.constraint(equalToConstant: 50).isActive = true
        totalPayment.leftAnchor.constraint(equalTo: payView.leftAnchor, constant: 20).isActive = true
        totalPayment.rightAnchor.constraint(equalTo: payView.rightAnchor, constant: -20).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.3)
        configureNavBar()
        view.addSubview(payView)
        payView.addSubview(cashPaymentView)
        cashPaymentView.addSubview(cashPaymentLabel)
        cashPaymentView.addSubview(cashButton)
        payView.addSubview(cardPaymentView)
        cardPaymentView.addSubview(cardPaymentLabel)
        cardPaymentView.addSubview(cardButton)
        payView.addSubview(totalPayment)
        payView.addSubview(titleLabel)
        setupView()
        totalAmountObserver = NotificationCenter.default.addObserver(forName: .totalAmount, object: nil, queue: OperationQueue.main, using: { (notification) in
            let mainVC = notification.object as! MainVC
            self.totalPayment.setTitle("Total amount to pay: $" + String(mainVC.totalAmountInfo!) , for: .normal)
    
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0.3)
        configureNavBar()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let totalAmountObserver = totalAmountObserver{
            NotificationCenter.default.removeObserver(totalAmountObserver)
        }
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }

}
