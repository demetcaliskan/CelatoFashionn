//
//  PaymentMethodViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 24.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var deliveryPaymentButton: UIButton!
    
    let iban: String = "Some iban text"
    var userPaymentMethod: String = ""
    var orders : [NotProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDesign()
    }
    
    
    @IBAction func transferMoneyButtonPressed(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "", message: iban, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Copy.", style: .default, handler: {
            _ in
            UIPasteboard.general.string = self.iban
            self.performSegue(withIdentifier: "paymentToComplete", sender: self)
        }))

        self.present(alert, animated: true, completion: nil)
        
        userPaymentMethod = "Money transfer."
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentToComplete" {
            let vc = segue.destination as! CompleteOrderViewController
            vc.orders = self.orders
        }
    }
    
    @IBAction func deliveryPaymentButtonPressed(_ sender: UIButton)
    {
        userPaymentMethod = "Payment when delivered."
        performSegue(withIdentifier: "paymentToComplete", sender: self)
    }
    
    
    func btnDesign()
    {
        transferButton.layer.borderWidth = 1
        transferButton.layer.borderColor = UIColor.gray.cgColor
        transferButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 25, bottom: 7, right: 25)
        transferButton.layer.cornerRadius = transferButton.frame.height/6
        
        deliveryPaymentButton.layer.borderWidth = 1
        deliveryPaymentButton.layer.borderColor = UIColor.gray.cgColor
        deliveryPaymentButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 25, bottom: 7, right: 25)
        deliveryPaymentButton.layer.cornerRadius = transferButton.frame.height/6
    }
    
    
}
