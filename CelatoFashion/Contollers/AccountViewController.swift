//
//  AccountViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 28.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "OrderCollectionViewCell"
    
    var items : [Item] = [Item(collectionViewName: "Product 1"),
                          Item(collectionViewName: "Product 2"),
                          Item(collectionViewName: "Product 3"),
                          Item(collectionViewName: "Product 4"),
                          Item(collectionViewName: "Product 2"),
                          Item(collectionViewName: "Product 1"),
                          Item(collectionViewName: "Product 4"),
                          Item(collectionViewName: "Product 3"),
                          Item(collectionViewName: "Product 1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
        setupCollectionView()
        setupNameLabel()
    }
    
    private func setupNameLabel()
    {
        var fontSize: CGFloat = 25
        let screenBounds = UIScreen.main.bounds
        let screenHeight = screenBounds.height
        if screenHeight/2 < 350
        {
            fontSize = 17
        }
        else if screenHeight/2 > 370 && screenHeight/2 < 370
        {
            fontSize = 20
        }
        else
        {
            fontSize = 25
        }
        if nameSurnameLabel.text!.count > 14
        {
            nameSurnameLabel.font = nameSurnameLabel.font.withSize(fontSize)
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
        let nib = UINib(nibName: "OrderCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 1
            let lineSpacing : CGFloat = 10
            let edgeSpacing : CGFloat = 10
            let interItemSpacing : CGFloat = 5
            let screenBounds = UIScreen.main.bounds
            let screen_width = screenBounds.width
            let width = (screen_width - 50) / numberOfItemsPerRow
            let height = width * 0.55
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: edgeSpacing, bottom: 0, right: edgeSpacing)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OrderCollectionViewCell
        
        cell.orderPicture.image = UIImage(named: items[indexPath.item].collectionViewName)
        cell.orderDate.text = "24 July 2020"
        cell.orderStatus.text = "Order placed."
        cell.orderTotalPrice.text = "650"
        cell.orderTrackNumber.text = "12345"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print("DidSelectItemAt \(indexPath)")
        performSegue(withIdentifier: "accountToOrder", sender: self)
    }
}

extension AccountViewController: UITabBarDelegate
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
