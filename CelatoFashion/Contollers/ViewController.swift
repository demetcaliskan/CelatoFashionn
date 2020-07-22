//
//  ViewController.swift
//  CelatoFashion
//
//  Created by Demet on 31.05.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }


    @IBAction func loginPressed(_ sender: Any) {
        if(emailTextField.text == "" || passwordTextField.text == "") {
            let alert = UIAlertController.init(title: "Error", message: "Email or Password can not be white space", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                print("Error happenned in login controllers alert")
            }))
            return
        }
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (dataResult, error) in
            print("SignedIn")
            self.goToHome()
        }

    }
    func goToHome() {
        
        let isSignedIn = true
        let userDefault = UserDefaults.standard
        userDefault.set(isSignedIn, forKey: "isSignedIn")
        let email = emailTextField.text
        userDefault.set(email, forKey: "email")
        
        let alert = UIAlertController(title: "Success", message: "Welcome back!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
           
            self.performSegue(withIdentifier: "loginToBag", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        performSegue(withIdentifier: "loginToRegister", sender: self)

    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

