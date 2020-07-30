//
//  OrderCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 28.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var orderTrackNumber: UILabel!
    @IBOutlet weak var orderPicture: UIImageView!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    @IBOutlet weak var numberOfOrders: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
