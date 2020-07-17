//
//  RegisterViewController.swift
//  CelatoFashion
//
//  Created by Demet on 10.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordAgainTextField.delegate = self

    }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordAgainTextField.resignFirstResponder()
        return true
    }
    @IBAction func registerPressed(_ sender: Any) {
        if(passwordTextField.text != passwordAgainTextField.text || emailTextField.text == "" || passwordAgainTextField.text == "") {
            let alert = UIAlertController(title: "Error" , message: "Passwords does not match! Also make sure that email or password field is not white space.", preferredStyle: .alert)
            passwordAgainTextField.text = ""
            passwordTextField.text = ""
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                print("Error occured while adding action to alert.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
            }
        else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordAgainTextField.text!) { (AuthDataResult, Error) in
                print(Error as Any)
                }
            }
    }
    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: "registerToLogin", sender: self)

    }
    
}
extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}

