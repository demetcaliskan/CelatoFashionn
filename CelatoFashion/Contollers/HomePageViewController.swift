//
//  HomePageViewController.swift
//  CelatoFashion
//
//  Created by Demet on 6.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

struct Item
{
    var collectionViewName : String
}

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var celatoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var bagButton: UIButton!
    
    
    var items : [Item] = [Item(collectionViewName: "Product 1"),
                         Item(collectionViewName: "Product 2"),
                         Item(collectionViewName: "Product 3"),
                         Item(collectionViewName: "Product 4"),
                         Item(collectionViewName: "Product 2"),
                         Item(collectionViewName: "Product 1"),
                         Item(collectionViewName: "Product 4"),
                         Item(collectionViewName: "Product 3"),
                         Item(collectionViewName: "Product 1")]
    
   
    var images: [UIImage] = []
    
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    var products: [NotProduct] = []
    var id = 0
    
    //Total number of products in the bag
    let bagItemSize = 5

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        self.tabBar.delegate = self
        bagButtonDesign()
        loadProducts()
        
    }
    
    private func bagButtonDesign()
    {
        bagButton.setTitle(String(bagItemSize), for: .normal)
        if bagButton.currentTitle?.count == 1
        {
            bagButton.titleEdgeInsets = UIEdgeInsets(top: 4, left: -32, bottom: 0, right: 0)
        }
        else
        {
            bagButton.titleEdgeInsets = UIEdgeInsets(top: 4, left: -37, bottom: 0, right: 0)
        }
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
                    let id = data["id"] as! String
                    
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
                    let storageRef = Storage.storage().reference()
                    let pathReference = storageRef.child(id)
                    pathReference.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                        
                        if let error = error {
                            print("error occured \(error)")
                        }
                        else {
                            let image = UIImage(data: data!)
                            product.setImage(image: image!)
                            self.products.append(product)
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    func loadImages() {
        let storageRef = Storage.storage().reference()
        for i in 0...self.products.count - 1 {
            let pathReferance = storageRef.child("\(i)")
            print("path reference is \(pathReferance)")
            pathReferance.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    print("error occured \(error)")
                }
                else {
                    print("??")
                    let image = UIImage(data: data!)
                    self.images.append(image!)
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
        if item.tag == 3
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("account bar item is selected")
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
        
        cell.itemImage.image = products[indexPath.item].getImage()
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
