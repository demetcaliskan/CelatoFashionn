//
//  SearchViewController.swift
//  CelatoFashion
//
//  Created by Demet on 10.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items : [Item] = [Item(collectionViewName: "Product 1"),
    Item(collectionViewName: "Product 2"),
    Item(collectionViewName: "Product 3"),
    Item(collectionViewName: "Product 4"),
    Item(collectionViewName: "Product 1"),
    Item(collectionViewName: "Product 1")]
    
    var searchActive: Bool = false
    
    var products: [NotProduct] = []
    var filteredProducts: [NotProduct] = []
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.tabBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.searchBar.delegate = self
        self.loadProducts()
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
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filteredProducts = products.filter { product in
            
            if product.getName() == searchText || product.getName().lowercased() == searchText.lowercased() {
                return true
            }
            else if product.getCategory() == searchText || product.getCategory().lowercased() == searchText.lowercased() {
                return true
            }
            else {
                return false
                
            }
            
        }
        if(filteredProducts.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        self.collectionView.reloadData()
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 2
            let lineSpacing : CGFloat = 5
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
                    storageRef.child(id).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
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
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredProducts.count
        }
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        if(searchActive == false) {
            cell.itemImage.image = products[indexPath.item].getImage()
            cell.itemName.text = products[indexPath.item].getName()
            print("cell at \(indexPath.item) 's name is \(cell.itemName.text!)")
            cell.itemPrice.text = "$" + products[indexPath.item].getPrice()
            }
        else {
            cell.itemImage.image = filteredProducts[indexPath.item].getImage()
            cell.itemName.text = filteredProducts[indexPath.item].getName()
            cell.itemPrice.text = "$" + filteredProducts[indexPath.item].getPrice()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DidSelectItemAt \(indexPath)")
        
        if(searchActive == false) {
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
        
        performSegue(withIdentifier: "searchToShow", sender: self)
        }
        else {
            let product = filteredProducts[indexPath.item]
            let defaults = UserDefaults.standard
            
            defaults.set(product.getName(), forKey: "name")
            defaults.set(product.getPrice(), forKey: "price")
            defaults.set(product.getSize(), forKey: "size")
            defaults.set(product.getAmount(), forKey: "amount")
            defaults.set(product.getColor(), forKey: "color")
            defaults.set(product.getId(), forKey: "id")
            defaults.set(product.getCategory(), forKey: "category")
            defaults.set(product.getGender(), forKey: "gender")
            
            performSegue(withIdentifier: "searchToShow", sender: self)
        }
    }
}

extension SearchViewController: UITabBarDelegate
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

