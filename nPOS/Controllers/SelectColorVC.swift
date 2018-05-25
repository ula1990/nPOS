//
//  SelectColorVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 25/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class SelectColorVC: UIViewController {
    
    var colorList: [Color] = []
    var selectedColor: String!
    var selectionDelegate: transferSelectedColorDelegate?

    lazy var selectColorView: UIView = {
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
        label.text = "Select Category"
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var selectColorPicker: UIPickerView = {
       let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
//        picker.backgroundColor = UIColor.black.withAlphaComponent(0)
        picker.tintColor = .white
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "done"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.tintColor = UIColor.white
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
        selectColorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectColorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        selectColorView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        selectColorView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: selectColorView.topAnchor).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: selectColorView.centerXAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        selectColorPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectColorPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        selectColorPicker.topAnchor.constraint(equalTo: infoLabel.bottomAnchor).isActive = true
        selectColorPicker.bottomAnchor.constraint(equalTo: dismissButton.topAnchor).isActive = true
        selectColorPicker.leftAnchor.constraint(equalTo: selectColorView.leftAnchor).isActive = true
        selectColorPicker.rightAnchor.constraint(equalTo: selectColorView.rightAnchor).isActive = true
        
        dismissButton.centerXAnchor.constraint(equalTo: selectColorView.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: selectColorView.bottomAnchor,constant: -5).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.addSubview(selectColorView)
        selectColorView.addSubview(dismissButton)
        selectColorView.addSubview(infoLabel)
        selectColorView.addSubview(selectColorPicker)
        selectColorPicker.delegate = self
        selectColorPicker.dataSource = self
        configureNavBar()
        setupView()
        colorList = temporaryColorArray()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        configureNavBar()
        
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func temporaryColorArray()->[Color]{
        var array: [Color] = []
        let item1 = Color(nameOfCategory: "2 persons", categoryColor: UIColor(named: "1")!)
        let item2 = Color(nameOfCategory: "4 persons", categoryColor: UIColor(named: "2")!)
        let item3 = Color(nameOfCategory: "6 persons", categoryColor: UIColor(named: "3")!)
        let item4 = Color(nameOfCategory: "1 persons", categoryColor: UIColor(named: "4")!)
        let item5 = Color(nameOfCategory: "8 persons", categoryColor: UIColor(named: "5")!)
        let item6 = Color(nameOfCategory: "12 persons", categoryColor: UIColor(named: "6")!)
        let item7 = Color(nameOfCategory: "3 persons", categoryColor: UIColor(named: "7")!)
        let item8 = Color(nameOfCategory: "7 persons", categoryColor: UIColor(named: "8")!)

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
