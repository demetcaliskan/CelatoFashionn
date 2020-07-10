//
//  BagItemCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet on 8.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class BagItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
