//
//  ItemCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet on 7.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func loadItem()
    {
//        if itemImage.interactions
    }
}
