//
//  SliderThumb.swift
//  FittingMakeup
//
//  Created by TakaoAtsushi on 2018/09/04.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit

struct SliderThumb {
    
    static func makeImage() -> UIImage {
        let thumbImageView = UIImageView()
        thumbImageView.backgroundColor = UIColor.white
        thumbImageView.layer.borderColor = UIColor.black.cgColor
        thumbImageView.layer.borderWidth = 0.3
        thumbImageView.frame.size = CGSize(width: 20, height: 20)
        thumbImageView.layer.cornerRadius = 10.0
        thumbImageView.layer.masksToBounds = true
        
        UIGraphicsBeginImageContextWithOptions(thumbImageView.frame.size, false, 2.0)
        thumbImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
