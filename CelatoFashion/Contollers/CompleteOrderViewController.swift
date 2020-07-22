//
//  CompleteOrderViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 21.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class CompleteOrderViewController: UIViewController {
    
    @IBOutlet weak var orderCompleteLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueShopButton: UIButton!
    
    var imgArray = [UIImage(named: "Product"),
                    UIImage(named: "Product 2"),
                    UIImage(named: "Product 2"),
                    UIImage(named: "Product 2"),
                    UIImage(named: "logo2")]
    
    let cellIdentifier = "OrderItemCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    var orders = [NotProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        btnDesign()
        setupCollectionView()
        
    }
    
    private func setupCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "OrderItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        setupCollectionViewItemSize()
    }
    
    
    func btnDesign()
    {
        continueShopButton.layer.borderWidth = 2
        continueShopButton.layer.borderColor = UIColor.black.cgColor
        continueShopButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    @IBAction func continueShoppingPressed(_ sender: Any) {
        
        let userDefault = UserDefaults.standard
        
        let emptyProductId : [String] = []
        userDefault.set(emptyProductId, forKey: "addedProducts")
        
        performSegue(withIdentifier: "completeToHome", sender: self)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            //input array's size determines number of items per row 
            var numberOfItemsPerRow : CGFloat
            if imgArray.count < 3
            {
                numberOfItemsPerRow = CGFloat(imgArray.count)
            }
            else
            {
                numberOfItemsPerRow = 3
            }
            
            let lineSpacing : CGFloat = 0
            
            let screenBounds = UIScreen.main.bounds
            let screen_width = screenBounds.width
            let screen_height = screenBounds.height
            
            let width = (screen_width) / numberOfItemsPerRow
            let height = screen_height/4 - 30
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right:0)
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = 1
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }

    
}

extension CompleteOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productSize = orders[indexPath.item].getSize()
        let productPrice = orders[indexPath.item].getPrice()
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OrderItemCollectionViewCell
        cell.productImage.image = imgArray[indexPath.row]
        cell.productName.text = orders[indexPath.item].getName()
        cell.productSizePrice.text = productSize + "  " + productPrice

        return cell
    }
}
