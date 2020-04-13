//
//  P1ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/13.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class P1ViewController: UIViewController ,  UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @IBOutlet weak var cameraRoleExplainLabel: UILabel!
    
    @IBOutlet var userImageView : UIImageView!
    @IBOutlet var button1 : UIButton!
    @IBOutlet var button2 : UIButton!
    
    var Image : UIImage!
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraRoleExplainLabel.text = "自分の顔全体が映った写真を撮るか\nカメラロールから選ぼう！"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        button1.layer.cornerRadius = 5.0// 角丸のサイズ
        button2.layer.cornerRadius = 5.0 
        
    }
       
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImageView.image = selectedImage
         image = userImageView.image
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        print(imageHeight, imageWidth)
//        let width = self.view.frame.width
//        let height = self.view.frame.height
//        let centerX = self.view.center.x
//        let centerY = self.view.center.y
//        let widthRatio = imageWidth
//        let heightRatio = imageHeight
//
//        //画像の大きさに応じてuserIamgeviewのサイズを変える
//        if imageHeight > self.view.frame.height || imageWidth > self.view.frame.width {
//            print("1")
//            imageWidth = width
//            imageHeight = width*heightRatio/widthRatio
//        } else if imageHeight > self.view.frame.height {
//            print("3")
//            imageHeight = height
//            imageWidth = height*widthRatio/heightRatio
//
//        } else if imageWidth > self.view.frame.width {
//            print("4")
//            imageWidth = width
//            imageHeight = width*heightRatio/widthRatio
//        } else {
//            print("そのままを表示")
//        }
//
//        userImageView.contentMode = UIViewContentMode.scaleAspectFill
//        userImageView.frame.size = CGSize(width: imageWidth, height: imageHeight)
//        print(imageHeight, imageWidth)
//        userImageView.center = CGPoint(x: centerX, y: centerY)
//        userImageView.image = image
//
        
        picker.dismiss(animated: true, completion: nil)
        let data = UIImagePNGRepresentation(userImageView.image!) 
        
       /* let resizedImage = selectedImage.scale(byFactor: 0.4)
        
        
        picker.dismiss(animated: true, completion: nil)
        let data = UIImagePNGRepresentation(resizedImage!) */
        
        /*
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
        userImageView.image = image */
        
       
        if NCMBUser.current() != nil {
            // やりたい動作
            
            let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: data) as! NCMBFile
            file.saveInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    self.userImageView.image = selectedImage
                }
                
            }) { (progress) in
                print(progress)
            }
        } else {
            // ログイン画面に戻る処理
            let storyboard = UIStoryboard(name: "SignIn" , bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
           
        }
        
       
    }
    
    
    // ”この画像を使う”ボタン
    @IBAction func confirmImage () {
        
        Image = userImageView.image
        self.performSegue(withIdentifier: "toP2", sender: nil)
    }
    
    //受渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を取得（次の画面のオブジェクトを取得する）
        let P2ViewController = segue.destination as! P2ViewController
        //次の画面の変数にこの画面の変数を入れていく
        
        P2ViewController.passedImage = Image
    }
    
    
    
    @IBAction func selectImage(){
        //アクションシートを出す
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }else{
                print("この機種ではカメラを使えません")
            }
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }else{
                print("この機種ではフォトライブラリは使えません")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel){(action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        
        // iPadでは必須！
        actionController.popoverPresentationController?.sourceView = self.view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        actionController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
            
        self.present(actionController, animated: true, completion: nil)
        
        func closeEditViewController() {
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
