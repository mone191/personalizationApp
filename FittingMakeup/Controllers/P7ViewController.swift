//
//  P7ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/31.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import AMChart
import NCMB
import SVProgressHUD

class P7ViewController: UIViewController , AMRadarChartViewDataSource{
   
    
     @IBOutlet weak var radarChartView: AMRadarChartView!
    //データの２重配列
    var radarDataList = [[0, 0, 0 , 0 , 0]]
    let titles = ["潤い度", "敏感度", "くすみ", "はり", "毛穴の目立ち"]
    
    @IBOutlet var  eyeLabel : UILabel!
    @IBOutlet var  lipLabel : UILabel!
    @IBOutlet var  skinLabel : UILabel!
    
    
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
    
    var temp1 : Int = 3
    var temp2 : Int = 3
    var temp3 : Int = 3
    var temp4 : Int = 3
    var temp5 : Int = 3
    
    var passedEyeType = Int()
    var passedLipType = Int()
    var passedSkinType = Int()
    
    var skinState = [Int]()
    
    var passedEyeState : Int!
    var passedLipState : Int!
    var passedSkinState : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        //radarChartView.dataSource = self
        //loadData()
        //showTypeData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        radarChartView.dataSource = self
        loadData()
        //showTypeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //表示するグラフの個数
    func numberOfSections(inRadarChartView radarChartView:AMRadarChartView) -> Int {
        return radarDataList.count
    }
    
    //項目の個数
    func numberOfRows(inRadarChartView radarChartView:AMRadarChartView) -> Int {
        return radarDataList[0].count
    }
    
    //各データの値
    func radarChartView(radarChartView:AMRadarChartView, valueForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(radarDataList[indexPath.section][indexPath.row])
    }
    
    
    //グラフの色（全体）
    func radarChartView(radarChartView:AMRadarChartView, fillColorForSection section: Int) -> UIColor {
        
        let r = 241
        let g = 155
        let b = 175
        
        return UIColor.rgba(red: r, green: g, blue: b, alpha: 0.7)
    }
    
    //グラフの枠線の色
    func radarChartView(radarChartView:AMRadarChartView, strokeColorForSection section: Int) -> UIColor {
        
        let r = 241
        let g = 155
        let b = 175
        return UIColor.rgba(red: r, green: g, blue: b, alpha: 0.7)
    }
    
    //項目
    func radarChartView(radarChartView: AMRadarChartView, titleForXlabelInRow row: Int) -> String {
        return titles[row]
    }
    


    func showTypeData() {
        DispatchQueue.main.async{
            if self.passedEyeType == 1{
                self.eyeLabel.text = "春"
                self.eyeView1.fillColor = UIColor.rgba(red: 255, green: 247, blue: 133, alpha: 1.0)
                self.eyeView2.fillColor = UIColor.rgba(red: 171, green: 230, blue: 204, alpha: 1.0)
                self.eyeView3.fillColor = UIColor.rgba(red: 208, green: 233, blue: 106, alpha: 1.0)
                self.eyeView4.fillColor = UIColor.rgba(red: 248, green: 207, blue: 144, alpha: 1.0)
                self.eyeView5.fillColor = UIColor.rgba(red: 173, green: 113, blue: 45, alpha: 1.0)
            } else if self.passedEyeType == 2 {
                self.eyeLabel.text = "夏"
                self.eyeView1.fillColor = UIColor.rgba(red: 197, green: 217, blue: 222, alpha: 1.0)
                self.eyeView2.fillColor = UIColor.rgba(red: 210, green: 142, blue: 186, alpha: 1.0)
                self.eyeView3.fillColor = UIColor.rgba(red: 200, green: 181, blue: 202, alpha: 1.0)
                self.eyeView4.fillColor = UIColor.rgba(red: 241, green: 253, blue: 173, alpha: 1.0)
                self.eyeView5.fillColor = UIColor.rgba(red: 162, green: 201, blue: 168, alpha: 1.0)
            } else if self.passedEyeType == 3{
                self.eyeLabel.text = "秋"
                self.eyeView1.fillColor = UIColor.rgba(red: 134, green: 138, blue: 94, alpha: 1.0)
                self.eyeView2.fillColor = UIColor.rgba(red: 213, green: 190, blue: 137, alpha: 1.0)
                self.eyeView3.fillColor = UIColor.rgba(red: 222, green: 213, blue: 122, alpha: 1.0)
                self.eyeView4.fillColor = UIColor.rgba(red: 87, green: 120, blue: 114, alpha: 1.0)
                self.eyeView5.fillColor = UIColor.rgba(red: 88, green: 56, blue: 21, alpha: 1.0)
            } else if self.passedEyeType == 4{
                self.eyeLabel.text = "冬"
                self.eyeView1.fillColor = UIColor.rgba(red: 250, green: 226, blue: 235, alpha: 1.0)
                self.eyeView2.fillColor = UIColor.rgba(red: 227, green: 243, blue: 248, alpha: 1.0)
                self.eyeView3.fillColor = UIColor.rgba(red: 38, green: 56, blue: 156, alpha: 1.0)
                self.eyeView4.fillColor = UIColor.rgba(red: 81, green: 52, blue: 102, alpha: 1.0)
                self.eyeView5.fillColor = UIColor.rgba(red: 195, green: 195, blue: 195, alpha: 1.0)
        } else{
                self.eyeLabel.text = "?"
                self.eyeView1.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.eyeView2.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.eyeView3.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.eyeView4.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.eyeView5.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        self.eyeView1.setNeedsDisplay()
        self.eyeView2.setNeedsDisplay()
        self.eyeView3.setNeedsDisplay()
        self.eyeView4.setNeedsDisplay()
        self.eyeView5.setNeedsDisplay()
        
            if self.passedLipType == 1 {
                self.lipLabel.text = "春"
                self.lipView1.fillColor = UIColor.rgba(red: 240, green: 127, blue: 119, alpha: 1.0)
                self.lipView2.fillColor = UIColor.rgba(red: 241, green: 145, blue: 111, alpha: 1.0)
                self.lipView3.fillColor = UIColor.rgba(red: 230, green: 66, blue: 37, alpha: 1.0)
            } else if self.passedLipType == 2 {
                self.lipLabel.text = "夏"
                self.lipView1.fillColor = UIColor.rgba(red: 185, green: 90, blue: 102, alpha: 1.0)
                self.lipView2.fillColor = UIColor.rgba(red: 215, green: 130, blue: 151, alpha: 1.0)
                self.lipView3.fillColor = UIColor.rgba(red: 223, green: 113, blue: 126, alpha: 1.0)
            } else if self.passedLipType == 3 {
                self.lipLabel.text = "秋"
                self.lipView1.fillColor = UIColor.rgba(red: 189, green: 61, blue: 42, alpha: 1.0)
                self.lipView2.fillColor = UIColor.rgba(red: 221, green: 125, blue: 100, alpha: 1.0)
                self.lipView3.fillColor = UIColor.rgba(red: 214, green: 142, blue: 87, alpha: 1.0)
            } else if self.passedLipType == 4{
                self.lipLabel.text = "冬"
                self.lipView1.fillColor = UIColor.rgba(red: 221, green: 53, blue: 148, alpha: 1.0)
                self.lipView2.fillColor = UIColor.rgba(red: 222, green: 29, blue: 99, alpha: 1.0)
                self.lipView3.fillColor = UIColor.rgba(red: 238, green: 108, blue: 162, alpha: 1.0)
     
        } else{
                self.lipLabel.text = "?"
                self.lipView1.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.lipView2.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.lipView3.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
            self.lipView1.setNeedsDisplay()
            self.lipView2.setNeedsDisplay()
            self.lipView3.setNeedsDisplay()
        
            if  self.passedSkinType == 1 {
                self.skinLabel.text = "春"
                self.skinView1.fillColor = UIColor.rgba(red: 243, green: 156, blue: 92, alpha: 1.0)
                self.skinView2.fillColor = UIColor.rgba(red: 243, green: 181, blue: 154, alpha: 1.0)
                self.skinView3.fillColor = UIColor.rgba(red: 236, green: 135, blue: 116, alpha: 1.0)
            } else if self.passedSkinType == 2 {
                self.skinLabel.text = "夏"
                self.skinView1.fillColor = UIColor.rgba(red: 209, green: 143, blue: 156, alpha: 1.0)
                self.skinView2.fillColor = UIColor.rgba(red: 222, green: 162, blue: 193, alpha: 1.0)
                self.skinView3.fillColor = UIColor.rgba(red: 217, green: 115, blue: 128, alpha: 1.0)
            } else if self.passedSkinType == 3 {
                self.skinLabel.text = "秋"
                self.skinView1.fillColor = UIColor.rgba(red: 223, green: 125, blue: 97, alpha: 1.0)
                self.skinView2.fillColor = UIColor.rgba(red: 242, green: 200, blue: 169, alpha: 1.0)
                self.skinView3.fillColor = UIColor.rgba(red: 214, green: 148, blue: 109, alpha: 1.0)
            } else if self.passedSkinType == 4{
                self.skinLabel.text = "冬"
                self.skinView1.fillColor = UIColor.rgba(red: 237, green: 98, blue: 140, alpha: 1.0)
                self.skinView2.fillColor = UIColor.rgba(red: 244, green: 183, blue: 202, alpha: 1.0)
                self.skinView3.fillColor = UIColor.rgba(red: 225, green: 95, blue: 148, alpha: 1.0)
       }else{
                self.skinLabel.text = "?"
                self.skinView1.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.skinView2.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
                self.skinView3.fillColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        
        self.skinView1.setNeedsDisplay()
        self.skinView2.setNeedsDisplay()
        self.skinView3.setNeedsDisplay()
        }
    }
    
    
    
    func loadData() {
        
        guard let currentUser = NCMBUser.current() else {
            //ログアウト成功
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewcontroller = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewcontroller
            //ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
            return
        }
        
        let query1 = NCMBQuery(className: "SkinCondition")
        query1?.includeKey("user")
        query1?.whereKey("user", equalTo: currentUser)
        query1?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                
                let postObject = result as! [NCMBObject]
                let newestObject = postObject.last
                
                if newestObject?.object(forKey: "temp1") == nil {
                    self.temp1 = 3
                    self.temp2 = 3
                    self.temp3 = 3
                    self.temp4 = 3
                    self.temp5 = 3
                } else {
                 self.temp1 = newestObject?.object(forKey: "temp1") as! Int
                 self.temp2 = newestObject?.object(forKey: "temp2") as! Int
                 self.temp3 = newestObject?.object(forKey: "temp3") as! Int
                 self.temp4 = newestObject?.object(forKey: "temp4") as! Int
                 self.temp5 = newestObject?.object(forKey: "temp5") as! Int
                }
                
                self.radarDataList[0][0] = self.temp1
                self.radarDataList[0][1] = self.temp2
                self.radarDataList[0][2] = self.temp3
                self.radarDataList[0][3] = self.temp4
                self.radarDataList[0][4] = self.temp5

                self.radarChartView.reloadData()
                
            }
        })
        
        
        let query2 = NCMBQuery(className: "RGB")
        query2?.includeKey("user")
        query2?.whereKey("user", equalTo: currentUser)
        query2?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                
                let postObject2 = result as! [NCMBObject]
               
              /* var arrray = [Int]()
                for object in postObject {
                    let eyeType = object.object(forKey: "eyetype") as! Int
                    arrray.append(eyeType)
                } */
                
                
                
                let newestObject2 = postObject2.last
                if newestObject2?.object(forKey: "eyetype") == nil {
                    self.passedEyeType = 0
                    self.passedLipType = 0
                    self.passedSkinType = 0
                    print("::::::::::::")
                   self.showTypeData()
                    
                } else {
                  
                self.passedEyeType = newestObject2?.object(forKey: "eyetype") as! Int
                self.passedLipType = newestObject2?.object(forKey: "liptype") as! Int
                self.passedSkinType = newestObject2?.object(forKey: "skintype") as! Int
                     print(";;;;;;;;;;;;;")
                    self.showTypeData()
                }
                
                
            }
            
        })
    }
}
    


