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
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    var categories = ["TSHIRTS", "SHORTS", "COATS", "SHOES", "TOWELS", "SALE"]
    let ecru = UIColor(displayP3Red: 242.0/255, green: 242.0/255, blue: 247.0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        
        let nib2 = UINib(nibName: "SellCategoryTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "SellCategoryTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tabBar.delegate = self
        
        btnDesign()
    }
    
    @IBAction func menBtnPressed(_ sender: Any)
    {
        categories = ["TSHIRTS", "SHORTS", "COATS", "SHOES", "TOWELS", "SALE"]
        womenBtn.backgroundColor = ecru
        womenBtn.setTitleColor(UIColor.darkGray, for: .normal)
        menBtn.backgroundColor = UIColor.darkGray
        menBtn.setTitleColor(ecru, for: .normal)
        
        tableView.reloadData()
    }
    
    @IBAction func womenBtnPressed(_ sender: Any)
    {
        categories = ["TSHIRTS", "SWIMWEAR", "COATS", "SHOES", "TOWELS", "SALE"]
        menBtn.backgroundColor = ecru
        menBtn.setTitleColor(UIColor.darkGray, for: .normal)
        womenBtn.backgroundColor = UIColor.darkGray
        womenBtn.setTitleColor(ecru, for: .normal)
        
        tableView.reloadData()
    }
    
    func btnDesign()
    {
        menBtn.layer.borderWidth = 0.7
        menBtn.layer.borderColor = UIColor.gray.cgColor
        
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

extension CategoryViewController: UITabBarDelegate
{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("tab bar is selected")
        if item.tag == 0
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("homepage bar item is selected")
        }
        if item.tag == 1
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("search bar item is selected")
        }
        if item.tag == 2
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("category bar item is selected")
        }
        if item.tag == 3
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("account bar item is selected")
        }
    }
}

extension CategoryViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if categories[indexPath.row] == "SALE"
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "SellCategoryTableViewCell", for: indexPath) as! SellCategoryTableViewCell
            cell.categoryCellName.text = categories[indexPath.row]
            return cell
        }
            
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.categoryCellName.text = categories[indexPath.row]
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
}




