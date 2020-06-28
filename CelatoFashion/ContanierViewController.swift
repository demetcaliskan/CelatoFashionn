//
//  ContanierViewController.swift
//  CelatoFashion
//
//  Created by Demet on 9.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class ContanierViewController: UIViewController {
    
    var pageNum : Int = 0

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNum = setPageNumber()
    }
    
    func setPageNumber() -> Int
    {
        var pageNum = 0
        while image1.centerXAnchor == CGFloat(0) as NSObject && image1.centerYAnchor == CGFloat(0) as NSObject
        {
            pageNum = 1
            print("image 1")
        }
        while image2.centerXAnchor == CGFloat(0) as NSObject && image2.centerYAnchor == CGFloat(0) as NSObject
        {
            pageNum = 2
            print("image 2")
        }
        while image3.centerXAnchor == CGFloat(0) as NSObject && image3.centerYAnchor == CGFloat(0) as NSObject
        {
            pageNum = 3
            print("image 3")
        }
        
        while image1.isAnimating == true {
            pageNum = 1
            print("image 1")
        }
        
//            print("Either page number is not calculated or you have more than 4 images.")

        
        return pageNum
        
    }

}
