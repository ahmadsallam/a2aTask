//
//  SignUpViewController.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/16/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//
import UIKit
import PasswordTextField
import FirebaseAuth

protocol SignUpViewControllerDelegate:NSObjectProtocol {
    func didSignUpSuccessfully(viewContorller:UIViewController)
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    weak var signUpViewControllerDelegate:SignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helping methods
    
    func setupView(){
        signUpButton.addTarget(self, action: #selector(signUpSelector), for: .touchUpInside)
    }
    
    @objc func signUpSelector(){
        view.endEditing(true)
        guard let email = emailTextField.text,!email.isEmpty else {
            showAlert(title: "Error", message: "Email is required", ok: "Ok")
            return
        }
        guard let password = passwordTextField.text,!password.isEmpty else {
            showAlert(title: "Error", message: "Password is required", ok: "Ok")
            return 
        }
        showActivityIndicator(message: "Please Wait")
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            self.hideActivityIndicator()
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", message: error, ok: "Ok")
                return
            }else{
                self.showAlertWithHandler(title: "Sucess", message: "The User Created", ok: "Ok", handler: { (action) in
                    self.signUpViewControllerDelegate?.didSignUpSuccessfully(viewContorller: self)
                })
            }
            if let newUser = Auth.auth().currentUser,let username = self.usernameTextField.text,!username.isEmpty {
                let changeRequst = newUser.createProfileChangeRequest()
                changeRequst.displayName = username
                changeRequst.commitChanges(completion: { (error) in
                    if error != nil {
                        self.showAlert(title: "Error", message: error?.localizedDescription, ok: "Ok")
                    }
                })
            }
        }
    }
    

}
