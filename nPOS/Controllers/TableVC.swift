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
    
    lazy var addTableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var addTableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Add New Table"
        return label
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
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        return button
        
    }()
    
    lazy var  addTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19 )
        button.addTarget(self, action: #selector(handleAddTable), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        button.tintColor = UIColor.white
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
    
    lazy var tableInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(named: "background")
        return view
    }()
    
    lazy var tableInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Table Info"
        return label
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
        
        addTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        addTableView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        addTableView.rightAnchor.constraint(equalTo: tableInfoView.leftAnchor, constant: -20).isActive = true
        addTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        tableInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        tableInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        tableInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableInfoView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 3.5).isActive = true
        
        tableInfoLabel.centerXAnchor.constraint(equalTo: tableInfoView.centerXAnchor).isActive = true
        tableInfoLabel.topAnchor.constraint(equalTo: tableInfoView.topAnchor).isActive = true
        tableInfoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tableInfoLabel.widthAnchor.constraint(equalTo: tableInfoView.widthAnchor).isActive = true
        
        tableCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableCollectionView.topAnchor.constraint(equalTo: addTableView.bottomAnchor, constant: 20).isActive = true
        tableCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tableCollectionView.rightAnchor.constraint(equalTo: tableInfoView.leftAnchor, constant: -20).isActive = true
        tableCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        addTableLabel.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        addTableLabel.topAnchor.constraint(equalTo: addTableView.topAnchor, constant: 20).isActive = true
        addTableLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addTableLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        idTextField.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        idTextField.topAnchor.constraint(equalTo: addTableLabel.bottomAnchor, constant: 20).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        idTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        tableNameTextField.leftAnchor.constraint(equalTo: addTableView.leftAnchor, constant: 20).isActive = true
        tableNameTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20).isActive = true
        tableNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tableNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        selectTableCategoryLabel.leftAnchor.constraint(equalTo: tableNameTextField.rightAnchor, constant: 50).isActive = true
        selectTableCategoryLabel.centerYAnchor.constraint(equalTo: addTableView.centerYAnchor).isActive = true
        selectTableCategoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectTableCategoryLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        selectColorButton.leftAnchor.constraint(equalTo: selectTableCategoryLabel.rightAnchor, constant: 5).isActive = true
        selectColorButton.centerYAnchor.constraint(equalTo: selectTableCategoryLabel.centerYAnchor).isActive = true
        selectColorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectColorButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        addTableButton.centerYAnchor.constraint(equalTo: selectColorButton.centerYAnchor).isActive = true
        addTableButton.leftAnchor.constraint(equalTo: selectColorButton.rightAnchor, constant: 50).isActive = true
        addTableButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addTableButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")?.withAlphaComponent(1)
        tables = temporaryTableArray()
        view.addSubview(tableCollectionView)
        view.addSubview(addTableView)
        view.addSubview(tableInfoView)
        addTableView.addSubview(addTableLabel)
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
        configureNavBar()
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSelectColor(){
        let colorVC = UINavigationController(rootViewController: SelectColorVC())
        colorVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(colorVC, animated: true, completion: nil)
    }
    
    @objc func finishedWithInput (){
        view.endEditing(true)
    }
    func temporaryTableArray()->[Table]{
        var array: [Table] = []
        let item1 = Table(id: 1,name: "Tabel",categoryColor: UIColor(named: "1")!)
        let item2 = Table(id: 2,name: "Tabel",categoryColor: (UIColor(named: "2"))!)
        let item3 = Table(id: 3,name: "Tabel",categoryColor: UIColor(named: "3")!)
        let item4 = Table(id: 4,name: "Tabel",categoryColor: UIColor(named: "4")!)
        let item5 = Table(id: 5,name: "Tabel",categoryColor: UIColor(named: "5")!)
        let item6 = Table(id: 6,name: "Tabel",categoryColor: UIColor(named: "6")!)
        let item7 = Table(id: 7,name: "Tabel",categoryColor: UIColor(named: "7")!)
        let item8 = Table(id: 8,name: "Tabel",categoryColor: UIColor(named: "1")!)
        let item9 = Table(id: 9,name: "Tabel",categoryColor: UIColor(named: "1")!)
        let item10 = Table(id: 10,name: "Tabel",categoryColor: UIColor(named: "4")!)
        let item11 = Table(id: 11,name: "Tabel",categoryColor: UIColor(named: "4")!)
        let item12 = Table(id: 12,name: "Tabel",categoryColor: UIColor(named: "8")!)
        let item13 = Table(id: 13,name: "Tabel",categoryColor: UIColor(named: "5")!)
        let item14 = Table(id: 14,name: "Tabel",categoryColor: UIColor(named: "5")!)
        let item15 = Table(id: 15,name: "Tabel",categoryColor: UIColor(named: "1")!)
        let item16 = Table(id: 16,name: "Tabel",categoryColor: UIColor(named: "1")!)
        let item17 = Table(id: 17,name: "Stuff",categoryColor: UIColor(named: "1")!)
    
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
        
        return array
    }
    
    
}
