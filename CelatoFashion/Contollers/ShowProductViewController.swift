//
//  ShowProductViewController.swift
//  CelatoFashion
//
//  Created by Demet on 8.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ShowProductViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addToBagBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var xsButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var lButton: UIButton!
    
    @IBOutlet weak var headerText: UINavigationItem!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var imgArray : [UIImage] = []
    
    let cellIdentifier = "ShowProductCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    var product : NotProduct = NotProduct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDesign()
        pageControl.numberOfPages = imgArray.count
        pageControl.currentPage = 0
        setupCollectionView()
        getProduct()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ShowProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize()
    {
        if collectionViewFlowLayout == nil
        {
            let numberOfItemsPerRow : CGFloat = 1
            let lineSpacing : CGFloat = 0
            let interItemSpacing : CGFloat = 0
            let screenBounds = UIScreen.main.bounds
            let screen_width = screenBounds.width
            let screen_height = screenBounds.height
            var width = (collectionView.frame.width - interItemSpacing) / numberOfItemsPerRow
            var height : CGFloat
            
            if screen_width < 330
            {
                width = (screen_width) / numberOfItemsPerRow
                print("Screen width is: \(screen_width)")
            }
            else if screen_width > 330 && screen_width < 400
            {
                width = (screen_width) / numberOfItemsPerRow
                print("Screen width is: \(screen_width)")
            }
            else
            {
                width = (screen_width) / numberOfItemsPerRow
                print("Screen width is: \(screen_width)")
            }
            
            if screen_height > 800
            {
                print(collectionView.frame.height)
                print("First")
                height = 395
            }
            else if screen_height > 700 && screen_height < 800
            {
                print(collectionView.frame.height)
                print("Second")
                height = 380
            }
            else
            {
                print("Last")
                height = 380 - (736 - screen_height)
            }
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right:0)
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = 1
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    func getProduct() {
        
        let defaults = UserDefaults.standard
        product = NotProduct(
            name: defaults.string(forKey: "name")!,
            amount: defaults.string(forKey: "amount")!,
            category: defaults.string(forKey: "category")!,
            color: defaults.string(forKey: "color")!,
            price: defaults.string(forKey: "price")!,
            size: defaults.string(forKey: "size")!,
            id: defaults.string(forKey: "id")!,
            gender: defaults.string(forKey: "gender")!)
        
            headerText.title = product.getName()
            priceLabel.text = ""
            priceLabel.text = "$" + product.getPrice()
        
            if product.getSize() == "XS" {
                sButton.isHidden = true
                mButton.isHidden = true
                lButton.isHidden = true
            }
            else if product.getSize() == "S" {
                xsButton.isHidden = true
                mButton.isHidden = true
                lButton.isHidden = true
            }
            else if product.getSize() == "M" {
                xsButton.isHidden = true
                sButton.isHidden = true
                lButton.isHidden = true
            }
            else if product.getSize() == "L" {
                xsButton.isHidden = true
                sButton.isHidden = true
                mButton.isHidden = true
            }
        let storageRef = Storage.storage().reference()
        storageRef.child(product.getId()).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error{
                print("error happened while retriving image \(error)")
            }
            else {
                let image = UIImage(data: data!)
                self.imgArray.append(image!)
                self.collectionView.reloadData()
            }
        }
    }
    
    func btnDesign()
    {
        addToBagBtn.layer.borderWidth = 2
        addToBagBtn.layer.borderColor = UIColor.gray.cgColor
        addToBagBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        addToBagBtn.layer.cornerRadius = addToBagBtn.frame.height/4
    }
    
    @IBAction func addToBagPressed(_ sender: Any)
    {
        let defaults = UserDefaults.standard
        if var addedProductsIds = defaults.array(forKey: "addedProducts") {
            addedProductsIds.append(self.product.getId())
            let uniqiueIds = removeDuplicates(array: addedProductsIds as! [String])
            defaults.set(uniqiueIds, forKey: "addedProducts")
        }
        else {
            var addedProductsIds : [String] = []
            addedProductsIds.append(self.product.getId())
            defaults.set(addedProductsIds, forKey: "addedProducts")
        }
        performSegue(withIdentifier: "showToBag", sender: self)
    }
    
    @IBAction func showToHomePressed(_ sender: Any) {
        performSegue(withIdentifier: "showToHome", sender: self)
    }
    
}

extension ShowProductViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShowProductCollectionViewCell
        cell.image.image =  imgArray[indexPath.row]
        return cell
    }
    
}
func removeDuplicates(array : [String]) -> [String] {
    var newArray : [String] = []
    for elements in array {
        if(newArray.contains(elements) == false) {
            newArray.append(elements)
        }
    }
    print(newArray)
    return newArray
}

extension ShowProductViewController: UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        print(indexPath.row)
        let counter = indexPath.row
        pageControl.currentPage = counter

    }
}
