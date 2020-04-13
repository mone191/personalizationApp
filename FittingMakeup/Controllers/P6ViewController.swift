//
//  P6ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/30.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD
import SCLAlertView


@IBDesignable

class P6ViewController: UIViewController {
    
   // @IBOutlet var  eyeImageView : UIImageView!
    //@IBOutlet var  lipImageView : UIImageView!
    //@IBOutlet var  skinImageView : UIImageView!
    
    @IBOutlet var  eyeLabel : UILabel!
    @IBOutlet var  lipLabel : UILabel!
    @IBOutlet var  skinLabel : UILabel!
    @IBOutlet var  eyelabel2 : UILabel!
    @IBOutlet var  lipLabel2 : UILabel!
    @IBOutlet var  skinLabel2 : UILabel!
    
    @IBOutlet var  eyeView1 : StarView!
    @IBOutlet var  eyeView2 : StarView!
    @IBOutlet var  eyeView3 : StarView!
    @IBOutlet var  eyeView4 : StarView!
    @IBOutlet var  eyeView5 : StarView!
    @IBOutlet var  lipView1 : StarView!
    @IBOutlet var  lipView2 : StarView!
    @IBOutlet var  lipView3 : StarView!
    @IBOutlet var  skinView1 : StarView!
    @IBOutlet var  skinView2 : StarView!
    @IBOutlet var  skinView3 : StarView!
    
    
    @IBOutlet var button : UIButton!
    
    
    
    var passedRGB = [CGFloat]()
    
    var skinState = [Int]()
    
    var  eyetype = Int()
    var  liptype = Int()
    var  skintype = Int()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       button.layer.cornerRadius = 5.0
        //ラベルの背景色を変える
        eyeLabel.backgroundColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 0.5)
        lipLabel.backgroundColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 0.5)
        skinLabel.backgroundColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 0.5)
        
      /*  //　ラベル枠の枠線太さと色
        eyeLabel.layer.borderColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 1.0) as! CGColor
        eyeLabel.layer.borderWidth = 2
        lipLabel.layer.borderColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 1.0) as! CGColor
        lipLabel.layer.borderWidth = 2
        skinLabel.layer.borderColor = UIColor.rgba(red: 241, green: 155, blue: 175, alpha: 1.0) as! CGColor
        skinLabel.layer.borderWidth = 2 */
        // ラベル枠を丸くする
        eyeLabel.layer.masksToBounds = true
        lipLabel.layer.masksToBounds = true
        skinLabel.layer.masksToBounds = true
        // ラベル丸枠の半径
        eyeLabel.layer.cornerRadius = 10
        lipLabel.layer.cornerRadius = 10
        skinLabel.layer.cornerRadius = 10

        
        
        showEyeData()
        showLipData()
        showSkinData()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
 
    
    
    func showEyeData() {
        if (passedRGB[2]/passedRGB[1]) >= 0.8{
            if (passedRGB[0]/passedRGB[2]) >= 1.5{
                //瞳は夏タイプ
                eyeLabel.text = "瞳は夏タイプです"
                eyelabel2.text = "パステルカラーや青みのある柔らかい色が似合います/ラメやパールはシルバーorピンクベースで/グラデーションは同系色でまとめよう"
                eyeView1.fillColor = UIColor.rgba(red: 197, green: 217, blue: 222, alpha: 1.0)
                eyeView2.fillColor = UIColor.rgba(red: 210, green: 142, blue: 186, alpha: 1.0)
                eyeView3.fillColor = UIColor.rgba(red: 200, green: 181, blue: 202, alpha: 1.0)
                eyeView4.fillColor = UIColor.rgba(red: 241, green: 253, blue: 173, alpha: 1.0)
                eyeView5.fillColor = UIColor.rgba(red: 162, green: 201, blue: 168, alpha: 1.0)
               // eyeImageView.image = UIImage(named: "summer eye.png")
                eyetype = 2
            }else{
                //瞳は冬タイプ
                eyeLabel.text = "瞳は冬タイプです"
                eyelabel2.text = "パキッとした色やメタリックカラーが似合います/ラメやパールはシルバーベースで/ラメやパールは大粒のものを"
                eyeView1.fillColor = UIColor.rgba(red: 250, green: 226, blue: 235, alpha: 1.0)
                eyeView2.fillColor = UIColor.rgba(red: 227, green: 243, blue: 248, alpha: 1.0)
                eyeView3.fillColor = UIColor.rgba(red: 38, green: 56, blue: 156, alpha: 1.0)
                eyeView4.fillColor = UIColor.rgba(red: 81, green: 52, blue: 102, alpha: 1.0)
                eyeView5.fillColor = UIColor.rgba(red: 195, green: 195, blue: 195, alpha: 1.0)
               // eyeImageView.image = UIImage(named: "winter eye.png")
                eyetype = 4
            }
        }else{
            if (passedRGB[0]/passedRGB[2]) >= 1.8{
                //瞳は春タイプ
                eyeLabel.text = "瞳は春タイプです"
                eyelabel2.text = "明るくてカラフルなビタミン色が似合います/ラメやパールはゴールドベースで/濃い色は締め色で使おう"
                eyeView1.fillColor = UIColor.rgba(red: 255, green: 247, blue: 133, alpha: 1.0)
                eyeView2.fillColor = UIColor.rgba(red: 171, green: 230, blue: 204, alpha: 1.0)
                eyeView3.fillColor = UIColor.rgba(red: 208, green: 233, blue: 106, alpha: 1.0)
                eyeView4.fillColor = UIColor.rgba(red: 248, green: 207, blue: 144, alpha: 1.0)
                eyeView5.fillColor = UIColor.rgba(red: 173, green: 113, blue: 45, alpha: 1.0)
               // eyeImageView.image = UIImage(named: "spring eye.png")
                eyetype = 1
            }else{
                //瞳は秋タイプ
                eyeLabel.text = "瞳は秋タイプです"
                eyelabel2.text = "黄味がかった落ち着いた色が似合います/ラメやパールはゴールドベースで/ラメやパールはは細かいものを"
                eyeView1.fillColor = UIColor.rgba(red: 134, green: 138, blue: 94, alpha: 1.0)
                eyeView2.fillColor = UIColor.rgba(red: 213, green: 190, blue: 137, alpha: 1.0)
                eyeView3.fillColor = UIColor.rgba(red: 222, green: 213, blue: 122, alpha: 1.0)
                eyeView4.fillColor = UIColor.rgba(red: 87, green: 120, blue: 114, alpha: 1.0)
                eyeView5.fillColor = UIColor.rgba(red: 88, green: 56, blue: 21, alpha: 1.0)
                //eyeImageView.image = UIImage(named: "autumn eye.png")
                eyetype = 3
            }
        }
    }
    
    func showLipData() {
        if (passedRGB[5]/passedRGB[4]) >= 1.1 {
            if (passedRGB[3]/passedRGB[5]) >= 1.3{
                //唇は夏タイプ
                lipLabel.text = "唇は夏タイプです"
                lipLabel2.text = "ピンクと赤がおすすめ/ピンクは青みorくすみのあるローズピンクで/赤は真紅よりも落ち着いたローズレッドで"
                lipView1.fillColor = UIColor.rgba(red: 185, green: 90, blue: 102, alpha: 1.0)
                lipView2.fillColor = UIColor.rgba(red: 215, green: 130, blue: 151, alpha: 1.0)
                lipView3.fillColor = UIColor.rgba(red: 223, green: 113, blue: 126, alpha: 1.0)
    
               // lipImageView.image = UIImage(named: "summer lip.png")
                liptype = 2
            }else{
                //唇は冬タイプ
                lipLabel.text = "唇は冬タイプです"
                lipLabel2.text = "ピンクと赤がおすすめ/ピンクはくすみがないものを/赤は深みのあるものを"
                lipView1.fillColor = UIColor.rgba(red: 221, green: 53, blue: 148, alpha: 1.0)
                lipView2.fillColor = UIColor.rgba(red: 222, green: 29, blue: 99, alpha: 1.0)
                lipView3.fillColor = UIColor.rgba(red: 238, green: 108, blue: 162, alpha: 1.0)
                
               // lipImageView.image = UIImage(named: "winter lip.png")
                liptype = 4
            }
        }else{
            if (passedRGB[3]/passedRGB[5]) >= 3.0{
                //唇は秋タイプ
                lipLabel.text = "唇は秋タイプです"
                lipLabel2.text = "オレンジがはいった赤がおすすめ/ヌーディーカラーもおすすめ"
                lipView1.fillColor = UIColor.rgba(red: 189, green: 61, blue: 42, alpha: 1.0)
                lipView2.fillColor = UIColor.rgba(red: 221, green: 125, blue: 100, alpha: 1.0)
                lipView3.fillColor = UIColor.rgba(red: 214, green: 142, blue: 87, alpha: 1.0)
                
               // lipImageView.image = UIImage(named: "autumn lip.png")
                liptype = 3
            }else{
                //唇は春タイプ
                lipLabel.text = "唇は春タイプです"
                lipLabel2.text = "明るくクリアな色が似合います/ツヤ感やパール感のあるものを"
                lipView1.fillColor = UIColor.rgba(red: 240, green: 127, blue: 119, alpha: 1.0)
                lipView2.fillColor = UIColor.rgba(red: 241, green: 145, blue: 111, alpha: 1.0)
                lipView3.fillColor = UIColor.rgba(red: 230, green: 66, blue: 37, alpha: 1.0)
                
                //lipImageView.image = UIImage(named: "spring lip.png")
                liptype = 1
            }
        }
    }
    
    func showSkinData() {
        if (passedRGB[8]/passedRGB[7]) >= 0.9 {
            if (passedRGB[6]/passedRGB[8]) >= 1.25{
                //肌色は夏タイプ
                skinLabel.text = "肌色は夏タイプです"
                skinLabel2.text = "チークの色は基本はピンクで/オレンジは避けよう"
                skinView1.fillColor = UIColor.rgba(red: 209, green: 143, blue: 156, alpha: 1.0)
                skinView2.fillColor = UIColor.rgba(red: 222, green: 162, blue: 193, alpha: 1.0)
                skinView3.fillColor = UIColor.rgba(red: 217, green: 115, blue: 128, alpha: 1.0)
               // skinImageView.image = UIImage(named: "summmer skin.png")
                skintype = 2

            }else{
                //肌色は冬タイプ
                skinLabel.text = "肌色は冬タイプです"
                skinLabel2.text = "チークはくすみのないピンクがおすすめ/シアー発色がおすすめ"
                skinView1.fillColor = UIColor.rgba(red: 237, green: 98, blue: 140, alpha: 1.0)
                skinView2.fillColor = UIColor.rgba(red: 244, green: 183, blue: 202, alpha: 1.0)
                skinView3.fillColor = UIColor.rgba(red: 225, green: 94, blue: 148, alpha: 1.0)
               // skinImageView.image = UIImage(named: "winter skin.png")
                skintype = 4

            }
        }else{
            if (passedRGB[6]/passedRGB[8]) >= 1.85{
                //肌色は秋タイプ
                skinLabel.text = "肌色は秋タイプです"
                skinLabel2.text = "深みのあるオレンジ系のチークがおすすめ/主張しすぎないなじみやすい色を選ぼう"
                skinView1.fillColor = UIColor.rgba(red: 223, green: 125, blue: 97, alpha: 1.0)
                skinView2.fillColor = UIColor.rgba(red: 242, green: 200, blue: 169, alpha: 1.0)
                skinView3.fillColor = UIColor.rgba(red: 214, green: 148, blue: 109, alpha: 1.0)
               // skinImageView.image = UIImage(named: "autumn skin.png")
                skintype = 3

            }else{
                //肌色は春タイプ
                skinLabel.text = "肌色は春タイプです"
                skinLabel2.text = "くすみのないオレンジが混ざった色を選ぼう/パール感があるものがおすすめ"
                skinView1.fillColor = UIColor.rgba(red: 243, green: 156, blue: 92, alpha: 1.0)
                skinView2.fillColor = UIColor.rgba(red: 243, green: 181, blue: 154, alpha: 1.0)
                skinView3.fillColor = UIColor.rgba(red: 236, green: 135, blue: 116, alpha: 1.0)
               // skinImageView.image = UIImage(named: "spring skin.png")
                skintype = 1

            }
        }
    }
    
    
    @IBAction func registrationButton() {
        
        let alertView = SCLAlertView()
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        //ボタンの追加
        let alert = SCLAlertView(appearance: appearance)
        alertView.addButton("OK",backgroundColor: UIColor.rgba(red: 247, green: 204, blue: 215, alpha: 1.0)) {
            
            let object = NCMBObject(className: "RGB")
            object?.setObject(self.eyetype, forKey: "eyetype")
            object?.setObject(self.liptype, forKey: "liptype")
            object?.setObject(self.skintype, forKey: "skintype")
            
            object?.setObject(NCMBUser.current(), forKey: "user")
            object?.saveInBackground({ (error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    print("ボタン１をタップしました")
                    self.tabBarController?.selectedIndex = 2
                   
                }
            })
        }
        //表示実行
        alertView.showInfo("登録が完了しました", subTitle: "", closeButtonTitle: "cancel",colorStyle: 0xf7ccd7)
       
  
    }
}


  
        
        
        
    


 
