//
//  ShoppingBagViewController.swift
//  CelatoFashion
//
//  Created by Demet on 7.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

struct Product {
    var collectionViewName : String
}

class ShoppingBagViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buyBtn: UIButton!
    
    var items : [Product] = [Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2")]
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "BagItemCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        btnDesign()
    }
    
    func btnDesign()
    {
        buyBtn.layer.borderWidth = 2
        buyBtn.layer.borderColor = UIColor.gray.cgColor
        buyBtn.contentEdgeInsets = UIEdgeInsets(top: 7, left: 25, bottom: 7, right: 25)
        buyBtn.layer.cornerRadius = buyBtn.frame.height/4
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "BagItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 1
            let lineSpacing : CGFloat = 30
            let edgeSpacing : CGFloat = 5
            let interItemSpacing : CGFloat = 5
            let width = (collectionView.frame.width - 100) / numberOfItemsPerRow
            let height = (width/3)*2
            
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

extension ShoppingBagViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BagItemCollectionViewCell
        
        cell.productImage.image = UIImage(named: items[indexPath.item].collectionViewName)
        cell.productName.text = "GIVENCHY"
        cell.productSize.text = "EU 42 (US 32)"
        cell.productPrice.text = "$1300"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("DidSelectItemAt\(indexPath)")
    }
}
