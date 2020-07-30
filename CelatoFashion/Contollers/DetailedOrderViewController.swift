//
//  DetailedOrderViewController.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 29.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class DetailedOrderViewController: UIViewController {
    
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var orderTrackNumber: UILabel!
    @IBOutlet weak var totalNumberOfOrders: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    let cellIdentifier = "DetailedOrderCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
     
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "detailedToAccount", sender: self)
    }
    
    
    private func setupCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "DetailedOrderCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 1
            let lineSpacing : CGFloat = 10
            let edgeSpacing : CGFloat = 5
            let interItemSpacing : CGFloat = 5
            let screenBounds = UIScreen.main.bounds
            let screen_width = screenBounds.width
            let width = (screen_width - 50) / numberOfItemsPerRow
            let height = width * 0.50
            
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

extension DetailedOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DetailedOrderCollectionViewCell
        
        cell.orderPicture.image = UIImage(named: items[indexPath.row].collectionViewName)
        cell.orderName.text = "Name"
        cell.orderSize.text = "S"
        cell.orderPrice.text = "500"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select item at: \(indexPath)")
    }
}
