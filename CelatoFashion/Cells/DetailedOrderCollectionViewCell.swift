//
//  DetailedOrderCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 28.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class DetailedOrderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var orderPicture: UIImageView!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderSize: UILabel!
    @IBOutlet weak var orderName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
