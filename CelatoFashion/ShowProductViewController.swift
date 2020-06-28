//
//  ShowProductViewController.swift
//  CelatoFashion
//
//  Created by Demet on 8.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class ShowProductViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addToBagBtn: UIButton!
    
    let vc = ContanierViewController(nibName: "ContanierViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSwap()
        btnDesign()
    }
    
    func pageSwap()
    {
        let pageNum = vc.pageNum
        pageControl.currentPage = pageNum
    }
    
    func btnDesign()
    {
        addToBagBtn.layer.borderWidth = 2
        addToBagBtn.layer.borderColor = UIColor.gray.cgColor
        addToBagBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        addToBagBtn.layer.cornerRadius = addToBagBtn.frame.height/4
    }
    
    @IBAction func addToBagPressed(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Do you have an account?", message:
               "You should have an account to be able to buy an item.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(nextViewController, animated:true, completion:nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Register", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            self.present(nextViewController, animated:true, completion:nil)
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    

}
