//
//  ShowProductViewController.swift
//  CelatoFashion
//
//  Created by Demet on 8.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class ShowProductViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addToBagBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgArray = [UIImage(named: "Product"),
                    UIImage(named: "Product 2"),
                    UIImage(named: "Product 3")]
    
    let cellIdentifier = "ShowProductCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDesign()
        pageControl.numberOfPages = imgArray.count
        pageControl.currentPage = 0
        setupCollectionView()
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
    
    func btnDesign()
    {
        addToBagBtn.layer.borderWidth = 2
        addToBagBtn.layer.borderColor = UIColor.gray.cgColor
        addToBagBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        addToBagBtn.layer.cornerRadius = addToBagBtn.frame.height/4
    }
    
    @IBAction func addToBagPressed(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Do you have an account?", message:
               "You should have an account to be able to buy an item.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(nextViewController, animated:true, completion:nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "Register", style: .default, handler: {
            (ACTION) in alertController.dismiss(animated: true, completion: nil)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            self.present(nextViewController, animated:true, completion:nil)
        }))

        self.present(alertController, animated: true, completion: nil)
    }

}

extension ShowProductViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShowProductCollectionViewCell
//        if let vc = cell.viewWithTag(1111) as? UIImageView
//        {
//            vc.image = imgArray[indexPath.row]
//        }
        cell.image.image =  imgArray[indexPath.row]
        

        return cell
    }
    
    
}

//extension ShowProductViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenBounds = UIScreen.main.bounds
//        let screen_width = screenBounds.width
//        let size = collectionView.frame.size
//        return CGSize(width: screen_width, height: (size.height))
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//}

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
