//
//  ViewController.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/16/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import PasswordTextField
import FirebaseAuth

class LoginViewController : UIViewController,SignUpViewControllerDelegate {
    
  
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var loginActivity: UIActivityIndicatorView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helping Method
    
    func setupView(){
        loginButton.addTarget(self, action:#selector(loginButtonSelector), for: .touchUpInside)
        loginActivity.isHidden = true

        //AS: Tap gesture recognizer for the signUp UILable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpLabelSelector))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Selector And Action
    
    @objc func loginButtonSelector(sender:UIButton) {
        view.endEditing(true)
//        guard let email = userNameTextField.text,!email.isEmpty else {
//            showAlert(title: "Error", message: "E-Mail is requierd to login", ok: "Ok")
//            return
//        }
//        guard let password = passwordTextField.text,!password.isEmpty else {
//            showAlert(title: "Error", message: "Password is requierd to login", ok: "Ok")
//            return
//        }
        let email = "a@a.com"
        let password = "ahmad123"
        signInLabel.isHidden = true
        loginActivity.isHidden = false
        loginActivity.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.loginActivity.stopAnimating()
            if let error = error {
                self.showAlertWithHandler(title: "Error", message: error.localizedDescription, ok: "Ok", handler: { (_) in
                    self.loginActivity.isHidden = true
                    self.signInLabel.isHidden = false
                })
            }else{
                if let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    self.show(homeVC, sender: self)
                
                }
            }
        }
        
    }
    
    @objc func signUpLabelSelector() {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {return}
        signUpVC.signUpViewControllerDelegate = self
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //MARK: - Delegate
    func didSignUpSuccessfully(viewContorller: UIViewController) {
        viewContorller.navigationController?.popViewController(animated: true)
    }
    
}

