//
//  ProductTypeTableViewCell.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit

class ProductTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var productTypeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


