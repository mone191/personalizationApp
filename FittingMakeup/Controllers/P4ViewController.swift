//
//  P4ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/26.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB

class P4ViewController: UIViewController {
    
    @IBOutlet var userImageView : UIImageView!
   
    var passedImage: UIImage!
    
    var image : UIImage!
    
    var passedRGB = [CGFloat]()
    
    var RGB = [CGFloat]()
    
    //表示されている画像のタップ座標用変数
    var tapPoint = CGPoint(x: 0, y: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        
        print("RGB値は")
        print(passedRGB)

        userImageView.image = passedImage
        
        image = userImageView.image
        
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        print(imageHeight, imageWidth)
        let width = self.view.frame.width
        let height = self.view.frame.height
        let centerX = self.view.center.x
        let centerY = self.view.center.y
        let widthRatio = imageWidth
        let heightRatio = imageHeight
        
        //画像の大きさに応じてuserIamgeviewのサイズを変える
        if imageHeight > self.view.frame.height || imageWidth > self.view.frame.width {
            print("1")
            imageWidth = width
            imageHeight = width*heightRatio/widthRatio
        } else if imageHeight > self.view.frame.height {
            print("3")
            imageHeight = height
            imageWidth = height*widthRatio/heightRatio
            
        } else if imageWidth > self.view.frame.width {
            print("4")
            imageWidth = width
            imageHeight = width*heightRatio/widthRatio
        } else {
            print("そのままを表示")
        }
        
        userImageView.contentMode = UIViewContentMode.scaleAspectFill
        userImageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
        print(imageHeight, imageWidth)
        userImageView.center = CGPoint(x: centerX, y: centerY)
        userImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //userImageviewをタップした時に色を判別
    @IBAction func getImageRGB(_ sender: UITapGestureRecognizer) {
        //タップした座標の取得
        tapPoint = sender.location(in: userImageView)
        
        let cgImage = userImageView.image?.cgImage!
        let pixelData = cgImage?.dataProvider!.data
        let data: UnsafePointer = CFDataGetBytePtr(pixelData)
        //1ピクセルのバイト数
        let bytesPerPixel = (cgImage?.bitsPerPixel)! / 8
        //1ラインのバイト数
        let bytesPerRow = (cgImage?.bytesPerRow)!
        print("bytesPerPixel=\(bytesPerPixel) bytesPerRow=\(bytesPerRow)")
        //タップした位置の座標にあたるアドレスを算出
        let pixelAd: Int = Int(tapPoint.y) * bytesPerRow + Int(tapPoint.x) * bytesPerPixel
        //それぞれRGBAの値をとる
        let r =  CGFloat(data[pixelAd])///CGFloat(255.0)*100)) / 100
        let g =  CGFloat(data[pixelAd+1])///CGFloat(255.0)*100)) / 100
        let b =  CGFloat(data[pixelAd+2])///CGFloat(255.0)*100)) / 100
        let a =  CGFloat(data[pixelAd+3])/CGFloat(255.0)*100 / 100
        
        let pixelColors = [r,g,b,a]
        
        
        print(pixelColors,tapPoint)
        RGB = [pixelColors[0],pixelColors[1],pixelColors[2]]
        
        
        self.performSegue(withIdentifier: "toP6", sender: nil)
    }
    
    //受渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を取得（次の画面のオブジェクトを取得する）
        let P6ViewController = segue.destination as! P6ViewController
       
        //RCB値の受け渡し
        P6ViewController.passedRGB =  passedRGB + RGB
    
    }

}
