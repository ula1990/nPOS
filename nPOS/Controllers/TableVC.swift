//
//  TableVC.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 24/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit


class TableVC: UIViewController {

    let tableCellId = "tableCellId"
    var tables: [Table] = []
    var observer: NSObjectProtocol?
    var selectedTable: String?
    
    lazy var addTableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "darkBackground")
        return view
    }()
    
    lazy var addTableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Add New Table"
        return label
    }()
    
    lazy var tableIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "new_table")
        return image
    }()
    
    lazy var idTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Id",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var tableNameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(string: "Enter Name of the Table",attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textColor = UIColor.white.withAlphaComponent(0.9)
        field.font = UIFont.systemFont(ofSize: 17)
        return field
    }()
    
    lazy var selectTableCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Select Table Category:"
        return label
    }()
    
    lazy var  selectColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor(named: "1")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleSelectColor), for: .touchUpInside)
        button.layer.cornerRadius = 2
//        button.layer.borderWidth = 2
//        button.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.8)
        return button
        
    }()
    
    lazy var  addTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleAddTable), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(named: "9")
        button.layer.cornerRadius = 2
        return button
        
    }()
    
    lazy var tableCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left:5, bottom: 5, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TableCell.self, forCellWithReuseIdentifier: tableCellId)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(0)
        view.isScrollEnabled = true
        return view
    }()
    
    
    lazy var tableInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Information"
        return label
    }()
    
    lazy var tableTextInfo: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.textColor = UIColor.white.withAlphaComponent(0.8)
        text.font = UIFont.systemFont(ofSize: 17)
        text.text = "To create a new table  you need to put first, id of the table in the text field from the left side of the screen,provide the name of the table,which staff can easily recognize and after that select category of the table which will show amount of the places on the table"
        text.backgroundColor = UIColor(named: "background")
        return text
    }()
    

    fileprivate func configureNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "dismiss"), style: .plain, target: self, action:#selector(handleDismiss))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "Select table"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    fileprivate func setupView(){
        
        addTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        addTableView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        addTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        addTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    
        tableCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableCollectionView.topAnchor.constraint(equalTo: addTableView.bottomAnchor, constant: 20).isActive = true
        tableCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        seperatorView.centerXAnchor.constraint(equalTo: addTableView.centerXAnchor).isActive = true
        seperatorView.centerYAnchor.constraint(equalTo: addTableView.centerYAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: addTableView.topAnchor, constant: 10).isActive = true
        seperatorView.bottomAnchor.constraint(equalTo: addTableView.bottomAnchor, constant: -10).isActive = true
        seperatorView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
        tableInfoLabel.topAnchor.constraint(equalTo: addTableView.topAnchor, constant: 20).isActive = true
        tableInfoLabel.rightAnchor.constraint(equalTo: addTableView.rightAnchor, constant: -20).isActive = true
        tableInfoLabel.leftAnchor.constraint(equalTo: seperatorView.leftAnchor, constant: 20).isActive = true
        tableInfoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tableTextInfo.topAnchor.constraint(equalTo: tableInfoLabel.bottomAnchor, constant: 5).isActive = true
        tableTextInfo.rightAnchor.constraint(equalTo: addTableView.rightAnchor, constant: -20).isActive = true
        tableTextInfo.leftAnchor.constraint(equalTo: seperatorView.leftAnchor, constant: 20).isActive = true
        tableTextInfo.bottomAnchor.constraint(equalTo: addTableView.bottomAnchor, constant: -20).isActive = true
        
        addTableLabel.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        addTableLabel.topAnchor.constraint(equalTo: addTableView.topAnchor, constant: 20).isActive = true
        addTableLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addTableLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        tableIcon.centerYAnchor.constraint(equalTo: addTableLabel.centerYAnchor).isActive = true
        tableIcon.leftAnchor.constraint(equalTo: addTableLabel.rightAnchor, constant: 20).isActive = true
        tableIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tableIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        idTextField.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        idTextField.topAnchor.constraint(equalTo: addTableLabel.bottomAnchor, constant: 20).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        idTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        tableNameTextField.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        tableNameTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20).isActive = true
        tableNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tableNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        selectTableCategoryLabel.leftAnchor.constraint(equalTo: tableNameTextField.rightAnchor, constant: 20).isActive = true
        selectTableCategoryLabel.centerYAnchor.constraint(equalTo: idTextField.centerYAnchor).isActive = true
        selectTableCategoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectTableCategoryLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        selectColorButton.topAnchor.constraint(equalTo: selectTableCategoryLabel.bottomAnchor, constant: 10).isActive = true
        selectColorButton.centerXAnchor.constraint(equalTo: selectTableCategoryLabel.centerXAnchor).isActive = true
        selectColorButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        selectColorButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        addTableButton.centerYAnchor.constraint(equalTo: selectTableCategoryLabel.centerYAnchor).isActive = true
        addTableButton.leftAnchor.constraint(equalTo: selectTableCategoryLabel.rightAnchor, constant: 10).isActive = true
        addTableButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTableButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        tables = temporaryTableArray()
        view.addSubview(tableCollectionView)
        view.addSubview(addTableView)
        addTableView.addSubview(addTableLabel)
        addTableView.addSubview(tableInfoLabel)
        addTableView.addSubview(tableTextInfo)
        addTableView.addSubview(seperatorView)
        addTableView.addSubview(tableIcon)
        addTableView.addSubview(idTextField)
        addTableView.addSubview(tableNameTextField)
        addTableView.addSubview(selectTableCategoryLabel)
        addTableView.addSubview(selectColorButton)
        addTableView.addSubview(addTableButton)
        
        tableCollectionView.delegate = self
        tableCollectionView.dataSource = self
        idTextField.delegate = self
        setupView()
        configureNavBar()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        idTextField.inputAccessoryView = toolBar
        tableNameTextField.inputAccessoryView = toolBar
        
        
        observer = NotificationCenter.default.addObserver(forName: .saveColor, object: nil, queue: OperationQueue.main, using: { (notification) in
            let colorVC = notification.object as! SelectColorVC
            self.selectColorButton.backgroundColor = colorVC.selectedColor
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let observer = observer{
        NotificationCenter.default.removeObserver(observer)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        observer = NotificationCenter.default.addObserver(forName: .saveColor, object: nil, queue: OperationQueue.main, using: { (notification) in
            let colorVC = notification.object as! SelectColorVC
            self.selectColorButton.backgroundColor = colorVC.selectedColor
        })
        configureNavBar()
    }
    
   
    
    
}
