//
//  CategoryViewController.swift
//  CelatoFashion
//
//  Created by Demet on 10.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let categories = ["TSHIRTS", "SWIMWEAR", "COATS", "SHOES", "TOWELS", "SALE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")

        tableView.delegate = self
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryCellName.text = categories[indexPath.row]
        
        if categories[indexPath.row] == "SALE"
        {
           
            cell.categoryCellName.textColor = UIColor.black
            cell.categoryCellName.font = UIFont.boldSystemFont(ofSize: 35)
//            cell.frame = cell.frame.inset(by: UIEdgeInsets(top: CGFloat(categories.count*30 + 100), left: 0, bottom: 0, right: 0))
//            cell.categoryCellName.frame = cell.categoryCellName.frame.inset(by: UIEdgeInsets(top: 100, left: 15, bottom: 0, right: 0))
            
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
}




