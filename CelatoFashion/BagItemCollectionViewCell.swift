//
//  BagItemCollectionViewCell.swift
//  CelatoFashion
//
//  Created by Demet on 8.06.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

protocol BagItemCollectionViewCellDelegate: class
{
    func delete(cell: BagItemCollectionViewCell)
}

class BagItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    weak var delegate : BagItemCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func deleteProduct(_ sender: UIButton) {
        delegate?.delete(cell: self)
    }
}
