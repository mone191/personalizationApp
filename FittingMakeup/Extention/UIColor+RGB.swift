//
//  UIColor+RGB.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/08/28.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
extension UIColor {
    
    static var makeUpPink = UIColor(red: 244/255, green: 173/255, blue: 185/255, alpha: 1.0)
    
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
