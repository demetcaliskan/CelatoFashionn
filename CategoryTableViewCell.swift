//
//  CategoryTableViewCell.swift
//  CelatoFashion
//
//  Created by Demet Çalışkan on 7.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryCellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
