//
//  HomePageViewController.swift
//  CelatoFashion
//
//  Created by Demet on 6.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Item
{
    var collectionViewName : String
}

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var celatoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    
    
    var items : [Item] = [Item(collectionViewName: "Product 1"),
                         Item(collectionViewName: "Product 2"),
                         Item(collectionViewName: "Product 3"),
                         Item(collectionViewName: "Product 4"),
                         Item(collectionViewName: "Product 2"),
                         Item(collectionViewName: "Product 1"),
                         Item(collectionViewName: "Product 4"),
                         Item(collectionViewName: "Product 3"),
                         Item(collectionViewName: "Product 1")]
    
   
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    var products: [NotProduct] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        self.tabBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        loadProducts()
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 2
            let lineSpacing : CGFloat = 15
            let interItemSpacing : CGFloat = 5
            var edgeSpacing : CGFloat = 5
            let screenBounds = UIScreen.main.bounds
            let screen_width = screenBounds.width
//            let screen_height = screenBounds.height
            var width = (collectionView.frame.width - interItemSpacing) / numberOfItemsPerRow
            
            if screen_width < 330
            {
                width = (screen_width - interItemSpacing - 20) / numberOfItemsPerRow
                edgeSpacing = 5
                print("Screen width is: \(screen_width)")
            }
            else if screen_width > 330 && screen_width < 400
            {
                width = (screen_width - interItemSpacing - 30) / numberOfItemsPerRow
                edgeSpacing = 10
                print("Screen width is: \(screen_width)")
            }
            else
            {
                width = (screen_width - interItemSpacing - 40) / numberOfItemsPerRow
                edgeSpacing = 10
                print("Screen width is: \(screen_width)")
            }
            let height = width*1.7
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: edgeSpacing, bottom: 0, right:edgeSpacing)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = 1
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    @IBAction func goToBag(_ sender: Any) {
        performSegue(withIdentifier: "homeToBag", sender: self)
        
    }
    func loadProducts(){
        Firestore.firestore().collection("products").getDocuments { (snapshot, error) in
            if let err = error {
            print("Error fetching docs: \(err)")
        } else {
                for document in (snapshot?.documents)! {

                    let data = document.data()
                    
                    let product = NotProduct(
                        name: data["name"] as! String,
                        amount: data["amount"] as! String,
                        category: data["category"] as! String,
                        color: data["color"] as! String,
                        price: data["price"] as! String,
                        size: data["size"] as! String,
                        id: data["id"] as! String,
                        gender: data["gender"] as! String)
                    
                    print(document.data())
                    
                    self.products.append(product)
                    self.collectionView.reloadData()
                }
                
            }
            
        }
    }

}

extension HomePageViewController: UITabBarDelegate
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
    }
}


extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        cell.itemImage.image = UIImage(named: items[indexPath.item].collectionViewName)
        cell.itemName.text = products[indexPath.item].getName()
        print("cell at \(indexPath.item) 's name is \(cell.itemName.text!)")
        cell.itemPrice.text = "$" + products[indexPath.item].getPrice()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("DidSelectItemAt \(products[indexPath.item].getName())")
        
        let product = products[indexPath.item]
        let defaults = UserDefaults.standard
        
        defaults.set(product.getName(), forKey: "name")
        defaults.set(product.getPrice(), forKey: "price")
        defaults.set(product.getSize(), forKey: "size")
        defaults.set(product.getAmount(), forKey: "amount")
        defaults.set(product.getColor(), forKey: "color")
        defaults.set(product.getId(), forKey: "id")
        defaults.set(product.getCategory(), forKey: "category")
        defaults.set(product.getGender(), forKey: "gender")
        
        performSegue(withIdentifier: "homeToShow", sender: self)
        
    }
}
