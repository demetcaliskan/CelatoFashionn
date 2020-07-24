//
//  UserInformationViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 24.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var saveMyInfoSwitch: UISwitch!
    @IBOutlet weak var doneButton: UIButton!
    
    let lightGrey = UIColor(displayP3Red: 204.0/255, green: 204.0/255, blue: 204.0/255, alpha: 1.0)
    let textViewTextColor = UIColor(displayP3Red: 196/255, green: 196/255, blue: 198/255, alpha: 1.0)
    
    //currentText variable is the address of the user
    var currentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberTextField.delegate = self
        self.districtTextField.delegate = self
        self.cityTextField.delegate = self
        self.countryTextField.delegate = self
        self.postCodeTextField.delegate = self
        addressTextView.delegate = self
        textViewDesign()
        btnDesign()
        saveMyInfoSwitch.addTarget(self, action: #selector(saveInformation), for: .valueChanged)
    }
    
    @objc func saveInformation(saveSwitch: UISwitch)
    {
        if saveSwitch.isOn
        {
            print("Switch is on! You can save user's information.")
        }
        else
        {
            print("Switch is off! You can not save user's information.")
        }
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
    
    func btnDesign()
    {
        doneButton.layer.borderWidth = 2
        doneButton.layer.borderColor = UIColor.gray.cgColor
        doneButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 25, bottom: 7, right: 25)
        doneButton.layer.cornerRadius = doneButton.frame.height/6
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberTextField.resignFirstResponder()
        districtTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        postCodeTextField.resignFirstResponder()
        return true
    }
    

}

extension UserInformationViewController: UITextViewDelegate
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
