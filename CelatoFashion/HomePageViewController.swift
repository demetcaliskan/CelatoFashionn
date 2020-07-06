//
//  HomePageViewController.swift
//  CelatoFashion
//
//  Created by Demet on 6.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

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
                         Item(collectionViewName: "Product 1"),
                         Item(collectionViewName: "Product 1")]
    
   
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
//    func tabBar(tabBar: UITabBar!, didSelectItem item: UITabBarItem!)
//    {
//        print("tab bar is selected")
//        if item.tag == 3
//        {
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.present(nextViewController, animated:true, completion:nil)
//            print("account bar item is selected")
//        }
//    }
    
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
//    {
//        print("tab bar is selected")
//        if item == accountBarItem
//        {
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.present(nextViewController, animated:true, completion:nil)
//            print("account bar item is selected")
//        }
//    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        self.tabBar.delegate = self
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
            var width = (collectionView.frame.width - interItemSpacing) / numberOfItemsPerRow
            var edgeSpacing : CGFloat = 5
            if collectionView.frame.width < 330
            {
                width = (collectionView.frame.width - interItemSpacing - 20) / numberOfItemsPerRow
                edgeSpacing = 5
                print("1.\(collectionView.frame.width)")
            }
            else if collectionView.frame.width > 330 && collectionView.frame.width < 400
            {
                width = (375 - interItemSpacing - 30) / numberOfItemsPerRow
                edgeSpacing = 10
                print("2.\(collectionView.frame.width)")
            }
            else
            {
                width = (414 - interItemSpacing - 40) / numberOfItemsPerRow
                edgeSpacing = 10
                print("3.\(collectionView.frame.width)")
            }
            let height = width*2
            
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
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(nextViewController, animated:true, completion:nil)
            print("account bar item is selected")
        }
    }
}


extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        cell.itemImage.image = UIImage(named: items[indexPath.item].collectionViewName)
        cell.itemName.text = "Demet"
        cell.itemPrice.text = "300"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DidSelectItemAt \(indexPath)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ShowProductViewController") as! ShowProductViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}
