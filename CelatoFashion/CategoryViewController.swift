//
//  CategoryViewController.swift
//  CelatoFashion
//
//  Created by Demet on 10.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var menBtn: UIButton!
    @IBOutlet weak var womenBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["TSHIRTS", "SHORTS", "COATS", "SHOES", "TOWELS", "SALE"]
    let ecru = UIColor(displayP3Red: 242.0/255, green: 242.0/255, blue: 247.0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        btnDesign()
    }
    
    @IBAction func menBtnPressed(_ sender: Any)
    {
        categories = ["TSHIRTS", "SHORTS", "COATS", "SHOES", "TOWELS", "SALE"]
        womenBtn.backgroundColor = ecru
        womenBtn.setTitleColor(UIColor.darkGray, for: .normal)
        menBtn.backgroundColor = UIColor.darkGray
        menBtn.setTitleColor(ecru, for: .normal)
    }
    
    @IBAction func womenBtnPressed(_ sender: Any)
    {
        categories = ["TSHIRTS", "SWIMWEAR", "COATS", "SHOES", "TOWELS", "SALE"]
        menBtn.backgroundColor = ecru
        menBtn.setTitleColor(UIColor.darkGray, for: .normal)
        womenBtn.backgroundColor = UIColor.darkGray
        womenBtn.setTitleColor(ecru, for: .normal)
    }
    
    func btnDesign()
    {
        menBtn.layer.borderWidth = 0.7
        menBtn.layer.borderColor = UIColor.gray.cgColor
//        menBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//        menBtn.layer.cornerRadius = menBtn.frame.height/4
        
        womenBtn.layer.borderWidth = 0.7
        womenBtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    

}

extension CategoryViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped a category!")
    }
}

extension CategoryViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        if categories[indexPath.row] == "SALE"
//        {
//             let cell = tableView.dequeueReusableCell(withIdentifier: "SellCategoryTableViewCell", for: indexPath) as! SellCategoryTableViewCell
//            cell.categoryCellName.text = categories[indexPath.row]
//
//            return cell
//        }
            
//        else
//        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.categoryCellName.text = categories[indexPath.row]
            return cell
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
}




