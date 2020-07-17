//
//  ShoppingBagViewController.swift
//  CelatoFashion
//
//  Created by Demet on 7.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Product {
    var collectionViewName : String
}

class ShoppingBagViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var items : [Product] = [Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                             Product(collectionViewName: "givenchy_coat2"),
                            ]
    
    var products: [NotProduct] = []
    
    
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    let cellIdentifier = "BagItemCollectionViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupCollectionView()
        btnDesign()
        getAddedProducts()
       
    }
    func getAddedProducts() {
        var total : Double = 0.0
        let defaults = UserDefaults.standard
        let addedProducts = defaults.array(forKey: "addedProducts")
        print(addedProducts)
        for id in addedProducts! {
            Firestore.firestore().collection("products").document(id as! String).getDocument { (document, error) in
                
                if let err = error {
                    print("Error getting docs: \(err)")
                }
                else {
                    print("id is \(id)")
                    let data = document?.data()
                    
                    let product = NotProduct(
                        name: data!["name"] as! String,
                        amount: data!["amount"] as! String,
                        category: data!["category"] as! String,
                        color: data!["color"] as! String,
                        price: data!["price"] as! String,
                        size: data!["size"] as! String,
                        id: data!["id"] as! String,
                        gender: data!["gender"] as! String)
                    let price = Double(product.getPrice())!
                    print("price is \(price)")
                    total = price + total
                    self.totalLabel.text = "$" + String(total)
                    print("total is changed and now is \(total)")
                    self.products.append(product)
                    self.collectionView.reloadData()
                }
            }
        
        }
        
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
    
    @IBAction func leftArrowPressed(_ sender: Any) {
        performSegue(withIdentifier: "bagToHome", sender: self)
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
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BagItemCollectionViewCell
        
        cell.productImage.image = UIImage(named: items[indexPath.item].collectionViewName)
        
        cell.productName.text = products[indexPath.item].getName()
        cell.productSize.text = products[indexPath.item].getSize()
        cell.productPrice.text = "$" + products[indexPath.item].getPrice()
        
        return cell
    }
    func didTap(_ cell: BagItemCollectionViewCell) {
        print("???")
        let indexPath = self.collectionView.indexPath(for: cell)
        print("indexpath is \(indexPath!)")
    }
}
extension ShoppingBagViewController: BagItemCollectionViewCellDelegate
{
    func delete(cell: BagItemCollectionViewCell) {
        if let indexPath = collectionView?.indexPath(for: cell)
        {
            //delete the cell from datasource
            print("delete triggered")
            let userDefault = UserDefaults.standard
            var productIds = userDefault.array(forKey: "addedProducts") as! [String]
            
            for i in 0..<productIds.count {
                if(products[indexPath.item].getId() == productIds[i]) {
                    productIds.remove(at: i)
                }
            }
            userDefault.set(productIds, forKey: "addedProducts")
            //delete the cell at that index path from the collection view
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}
