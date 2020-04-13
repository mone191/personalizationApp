//
//  CosmeTableViewCell.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import TTTAttributedLabel

protocol CosmeTableViewCellDelegate {
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel)
    //お気に入り登録
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton)
}

class CosmeTableViewCell: UITableViewCell, TTTAttributedLabelDelegate {
    
    var delegate: CosmeTableViewCellDelegate?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productColorLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productWebUrlLabel: TTTAttributedLabel!
    //お気に入り登録
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productWebUrlLabel.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        productWebUrlLabel.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.delegate?.didTapLink(tableViewCell: self, label: label)
    }
    
    @IBAction func like(button: UIButton) {
        self.delegate?.didTapLikeButton(tableViewCell: self, button: button)
    }
    
    
    
}
