//
//  CategoryProductsViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 17.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class CategoryProductsViewController: UIViewController {
    
    
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var bagButton: UIBarButtonItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    var items : [Item] = [Item(collectionViewName: "Product 1"),
                          Item(collectionViewName: "Product 2"),
                          Item(collectionViewName: "Product 3"),
                          Item(collectionViewName: "Product 4"),
                          Item(collectionViewName: "Product 1"),
                          Item(collectionViewName: "Product 1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.tabBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
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

}

extension CategoryProductsViewController: UITabBarDelegate
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

extension CategoryProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        cell.itemImage.image = UIImage(named: items[indexPath.item].collectionViewName)
        cell.itemName.text = "item name"
        cell.itemPrice.text = "$500"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("DidSelectItemAt \(indexPath)")
    }
}
