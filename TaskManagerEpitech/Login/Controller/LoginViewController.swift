//
//  LoginViewController.swift
//  TaskManagerEpitech
//
//  Created by Valentin Limagne on 15/02/2018.
//  Copyright © 2018 Valentin Limagne. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginToList = "LoginToList"
    
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var EtatConnectionView: UIView!
    @IBOutlet weak var EtatConnectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.EtatConnectionView.isHidden = true
        self.EmailTF.delegate = self
        self.PasswordTF.delegate = self
        
        Auth.auth().addStateDidChangeListener() {
            (auth, user) in
            if user != nil {
                let HomeVC = HomeViewController()
                self.show(HomeVC, sender: self)
            }
            
        }
        
    }
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: EmailTF.text!, password: PasswordTF.text!) {
            (user, error) in
            if let error = error {
                self.EtatConnectionView.isHidden = false
                self.EtatConnectionView.backgroundColor = UIColor.red
                self.EtatConnectionLabel.text = error.localizedDescription
                return
            } else {
                self.EtatConnectionView.isHidden = false
                self.EtatConnectionView.backgroundColor = UIColor.green
                self.EtatConnectionLabel.text = "Connection succes"
                
                let vc = HomeViewController()
                self.show(vc, sender: self)
            }
        }
    }
    
    @IBAction func SignUpBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
                                        
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if error == nil {
                    self.EtatConnectionView.isHidden = false
                    self.EtatConnectionView.backgroundColor = UIColor.green
                    self.EtatConnectionLabel.text = "Sign Up succes"
                } else {
                    self.EtatConnectionView.isHidden = false
                    self.EtatConnectionView.backgroundColor = UIColor.red
                    self.EtatConnectionLabel.text = error?.localizedDescription
                    return
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailTF {
            PasswordTF.becomeFirstResponder()
        }
        if textField == PasswordTF {
            textField.resignFirstResponder()
        }
        return true
    }
}
