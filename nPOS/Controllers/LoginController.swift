//
//  LoginController.swift
//  nPOS
//
//  Created by Uladzislau Daratsiuk on 22/05/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController {
    
    var mainController: MainVC?
    
    let inputsContainerView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var  loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor(white: 1, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLoginregister), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "9")
        return button
        
    }()
    
    @objc func handleLoginregister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else {
            handleRegister()
        }
    }
    
    func handleLogin () {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            Alert.showBasic(title: "Incorrect input", msg: "Please check you that email and password is correct", vc: self)
            view.endEditing(true)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                Alert.showBasic(title: "Please check input", msg: "Username or password is incorrect", vc: self)
                self.view.endEditing(true)
                return
            }
            self.mainController?.fetchUserAndSetupNavBarTitle()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        return tf
        
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 17)
        return tf
        
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 17)
        return tf
        
    }()
    
    lazy var logoLeeroy: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leeroyLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(named: "9")
        sc.backgroundColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        sc.layer.cornerRadius = 5
        return sc
    }()
    
    lazy var applePayLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "applepay")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var androidPayLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "androidpay")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    lazy var mastercardLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "masterCard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal )
        
        inputsContainerViewHightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextFieldHidthAnchor?.isActive = false
        nameTextFieldHidthAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3 )
        nameTextFieldHidthAnchor?.isActive = true
        
        emailTextFieldHightAnchor?.isActive = false
        emailTextFieldHightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        emailTextFieldHightAnchor?.isActive = true
        
        passwordTextFieldHigthAnchor?.isActive = false
        passwordTextFieldHigthAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        passwordTextFieldHigthAnchor?.isActive = true
        
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "darkBackground")
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(logoLeeroy)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(applePayLogoImageView)
        view.addSubview(androidPayLogoImageView)
        view.addSubview(mastercardLogoImageView)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
        setupLogoImages()
    }
    
    func setupLoginRegisterSegmentedControl(){
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupProfileImageView(){
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 145).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 145).isActive = true
    }
    
    var inputsContainerViewHightAnchor: NSLayoutConstraint?
    var nameTextFieldHidthAnchor: NSLayoutConstraint?
    var emailTextFieldHightAnchor: NSLayoutConstraint?
    var passwordTextFieldHigthAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView(){
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        inputsContainerViewHightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 135)
        inputsContainerViewHightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHidthAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHidthAnchor?.isActive = true
        
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHightAnchor?.isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHigthAnchor =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHigthAnchor?.isActive = true
        
    }
    
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    
    func setupLogoImages(){
        
        logoLeeroy.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        logoLeeroy.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        logoLeeroy.widthAnchor.constraint(equalToConstant: 120).isActive = true
        logoLeeroy.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        applePayLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        applePayLogoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        applePayLogoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        applePayLogoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        androidPayLogoImageView.centerYAnchor.constraint(equalTo: applePayLogoImageView.centerYAnchor).isActive = true
        androidPayLogoImageView.leftAnchor.constraint(equalTo: applePayLogoImageView.rightAnchor, constant: 10).isActive = true
        androidPayLogoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        androidPayLogoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        androidPayLogoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mastercardLogoImageView.centerYAnchor.constraint(equalTo: applePayLogoImageView.centerYAnchor).isActive = true
        mastercardLogoImageView.rightAnchor.constraint(equalTo: applePayLogoImageView.leftAnchor, constant: -10).isActive = true
        mastercardLogoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mastercardLogoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        mastercardLogoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat ){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

