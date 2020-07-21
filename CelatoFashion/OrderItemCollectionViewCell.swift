//
//  OrderItemCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 21.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class OrderItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSizePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
