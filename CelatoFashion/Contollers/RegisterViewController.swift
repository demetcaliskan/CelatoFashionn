//
//  RegisterViewController.swift
//  CelatoFashion
//
//  Created by Demet on 10.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    @IBOutlet weak var nameSurnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    let lightGrey = UIColor(displayP3Red: 204.0/255, green: 204.0/255, blue: 204.0/255, alpha: 1.0)
    let textViewTextColor = UIColor(displayP3Red: 196/255, green: 196/255, blue: 198/255, alpha: 1.0)
    
    //currentText variable is the address of the user
    var currentText: String = ""
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordAgainTextField.delegate = self
        self.nameSurnameTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.districtTextField.delegate = self
        self.cityTextField.delegate = self
        self.countryTextField.delegate = self
        self.postCodeTextField.delegate = self
        addressTextView.delegate = self
        textViewDesign()

    }
    
    func textViewDesign()
    {
        addressTextView.text = "Address"
        addressTextView.textColor = textViewTextColor
        addressTextView.backgroundColor = UIColor.white
    
        addressTextView.layer.borderWidth = 1
        addressTextView.layer.borderColor = lightGrey.cgColor
        addressTextView.layer.cornerRadius = addressTextView.frame.height / 20
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        passwordAgainTextField.resignFirstResponder()
        nameSurnameTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        districtTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        postCodeTextField.resignFirstResponder()
        return true
    }
    
    func canAddressBeSaved()
    {
        let alertController = UIAlertController(title: "Can we save your information?", message:
               "Do you want your information to be saved so you won't have to enter it next time.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Yes.", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            print("Yes.")
        }))
        
        alertController.addAction(UIAlertAction(title: "No.", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            print("No")
        }))

        self.present(alertController, animated: true, completion: nil)

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
            canAddressBeSaved()
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordAgainTextField.text!) { (AuthDataResult, Error) in
                print(Error as Any)
                }
            Firestore.firestore().collection("users").document(emailTextField.text!).setData([
                "Full name": nameSurnameTextField.text!,
                "Phone Number": phoneNumberTextField.text!,
                "District": districtTextField.text!,
                "City": cityTextField.text!,
                "Country": countryTextField.text!,
                "Postal Code": postCodeTextField.text!,
                "Address": addressTextView.text!
            ]) {
                err in
                
                if let err = err{
                    print("error writing document: \(err)")
                }
                else {
                    print("Document written successfully")
                    self.performSegue(withIdentifier: "registerToBag", sender: self)
                }
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

extension RegisterViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if addressTextView.textColor == textViewTextColor {
            addressTextView.text = nil
            addressTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //currentText variable contains the current data which user has currently typed in
        //in another words currentText variable is the address of the user
        currentText = addressTextView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if addressTextView.text.isEmpty {
            addressTextView.text = "Address"
            addressTextView.textColor = UIColor.lightGray
        }
    }
    
    
    
}

