//
//  P2ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/13.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB

class P2ViewController: UIViewController {
    
     @IBOutlet var userImageView : UIImageView!
    
    @IBOutlet var label : UILabel!
    
    var passedImage: UIImage!
    
    var countTap = 0
    
    var image : UIImage!
    
    var RGB = [CGFloat]()
    
    //表示されている画像のタップ座標用変数
    var tapPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.layer.cornerRadius = 5.0
       
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)

        
        image = passedImage
        userImageView.backgroundColor = .red
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        let width = self.view.frame.width
        let height = self.view.frame.height//画面全体の高さ、ここからnavigation barやtabbar、ラベルの高さを引く！
        
        let navigationController: UINavigationController = UINavigationController()
        let navigationBarHeight = navigationController.navigationBar.frame.size.height
        let tabBarController: UITabBarController = UITabBarController()
        let tabBarHieght = tabBarController.tabBar.frame.size.height
        let labelHeight = label.frame.height
        //
        //        let height = totalHeight - navigationBarHeight - tabBarHieght - labelHeight
        print(height, "test")
        let centerX = self.view.center.x
        let centerY = self.view.center.y
        let widthRatio = imageWidth
        let heightRatio = imageHeight
        
        //画像の大きさに応じてuserIamgeviewのサイズを変える
        if imageHeight > height || imageWidth > width {
            print("1")
            imageWidth = width
            imageHeight = width*heightRatio/widthRatio
        } else if imageHeight > height {
            print("3")
            imageHeight = height
            imageWidth = height*widthRatio/heightRatio
            
        } else if imageWidth > width {
            print("4")
            imageWidth = width
            imageHeight = width*heightRatio/widthRatio
        } else {
            print("そのままを表示")
        }
        
        userImageView.contentMode = UIViewContentMode.scaleAspectFill
        userImageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
        
        
        //画像がnavigationbar, tababr, labelに被らないようにする
        if imageHeight/2 > (height/2 - navigationBarHeight - labelHeight) {
            print("4")
            userImageView.center = CGPoint(x: centerX, y: centerY + navigationBarHeight + labelHeight)
        } else {
            print("5")
            userImageView.center = CGPoint(x: centerX, y: centerY)
        }
        
        userImageView.image = image
        
        
    }
    
    
      /*userImageView.image = passedImage
        
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
    
     
 */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RGB = []
        countTap = 0
        label.text = "画像の瞳（黒目の部分）をタップしよう" 
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
        
        let  pixelColors = [r,g,b,a]
        
        print(pixelColors,tapPoint)
        
        label.layer.cornerRadius = 5.0
       
        RGB += [pixelColors[0],pixelColors[1],pixelColors[2]]
        print(RGB)
        
        countTap = countTap + 1
        
        if countTap == 0{
            label.text = "画像の瞳（黒目の部分）をタップしよう"
        } else if countTap == 1{
            label.text = "画像の唇をタップしよう"
        }else if countTap == 2 {
            label.text = "画像の頬をタップしよう"
        } else {}
        if countTap == 3{
        self.performSegue(withIdentifier: "toP3", sender: nil)
        }
        
    }
    
   
            
    
    
    
    //受渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を取得（次の画面のオブジェクトを取得する）
        let P6ViewController = segue.destination as! P6ViewController
        //次の画面の変数にこの画面の変数を入れていく
       // P6ViewController.passedImage = image
        //RCB値の受け渡し
        P6ViewController.passedRGB = [CGFloat](RGB)
        
    }
    
        
}
    
    
    

