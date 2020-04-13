//
//  P5ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/26.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import NCMB
import SVProgressHUD
import SCLAlertView
import FontAwesomeKit


class P5ViewController: UIViewController {
    
    var passedRGB = [CGFloat]()
    var skinState = [Int]()
    var temp1 : Int = 0
    var temp2 : Int = 0
    var temp3 : Int = 0
    var temp4 : Int = 0
    var temp5 : Int = 0

    var locationManager = CLLocationManager()
    
    @IBOutlet var slider1 : UISlider!
    @IBOutlet var slider2 : UISlider!
    @IBOutlet var slider3 : UISlider!
    @IBOutlet var slider4 : UISlider!
    @IBOutlet var slider5 : UISlider!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    @IBOutlet var label10: UILabel!
     @IBOutlet var label11: UILabel!
    
    @IBOutlet var button1 : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.cornerRadius = 5.0
        
        locationManager.requestWhenInUseAuthorization()
        
        print("RGB値は")
        print(passedRGB)
        
        
        
        slider1.setThumbImage(SliderThumb.makeImage(), for: .normal)
        slider2.setThumbImage(SliderThumb.makeImage(), for: .normal)
        slider3.setThumbImage(SliderThumb.makeImage(), for: .normal)
        slider4.setThumbImage(SliderThumb.makeImage(), for: .normal)
        slider5.setThumbImage(SliderThumb.makeImage(), for: .normal)

        
        slider1.addTarget(self, action: #selector(sliderChanged1(sender:)), for: UIControlEvents.valueChanged)
        slider2.addTarget(self, action: #selector(sliderChanged2(sender:)), for: UIControlEvents.valueChanged)
        slider3.addTarget(self, action: #selector(sliderChanged3(sender:)), for: UIControlEvents.valueChanged)
        slider4.addTarget(self, action: #selector(sliderChanged4(sender:)), for: UIControlEvents.valueChanged)
        slider5.addTarget(self, action: #selector(sliderChanged5(sender:)), for: UIControlEvents.valueChanged)
        
        label6.attributedText = FAKFontAwesome.tintIcon(withSize: 25).attributedString()
        label7.attributedText = FAKFontAwesome.boltIcon(withSize: 25).attributedString()
        label8.attributedText = FAKFontAwesome.alignCenterIcon(withSize: 25).attributedString()
        label9.attributedText = FAKFontAwesome.tintIcon(withSize: 25).attributedString()
        label10.attributedText = FAKFontAwesome.dotCircleOIcon(withSize: 25).attributedString()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard (NCMBUser.current()) != nil else {
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
        
       // getCoordinate()
        loadData()
    }
    
    // セグメントボタン押下時に実行するメソッド
    @objc func sliderChanged1(sender: UISlider){
        temp1 = Int(sender.value)
        label1.text = String(temp1)
    }
    @objc func sliderChanged2(sender: UISlider){
        temp2 = Int(sender.value)
        label2.text = String(temp2)
    }
    @objc func sliderChanged3(sender: UISlider){
        temp3 = Int(sender.value)
        label3.text = String(temp3)
    }
    @objc func sliderChanged4(sender: UISlider){
        temp4 = Int(sender.value)
        label4.text = String(temp4)
    }
    @objc func sliderChanged5(sender: UISlider){
        temp5 = Int(sender.value)
        label5.text = String(temp5)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面を取得（次の画面のオブジェクトを取得する）
        let P7ViewController = segue.destination as! P7ViewController
        
        //RCB値の受け渡し
        //P7ViewController.passedRGB =  passedRGB
        
        //５つの基準値の受け渡し
        P7ViewController.skinState =  skinState
        
    }
    */
   /* func getCoordinate() {
        // 現在地の緯度経度
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        //表示する時の中心となる場所を指定する（nilに注意）
        if let unwrappedLatitude = latitude {
            getWeather(latitude: unwrappedLatitude, longitude: longitude!)
        } else {
            getWeather(latitude: 36, longitude: 139)
        }
    }
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let apiKey = "3483e0f01f8a1a2d994f514868c7307a"
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)", method: .get).responseJSON { response in
            guard let object = response.result.value else {
                return
            }
            let json = JSON(object)
            print(json)
            let weather = json["weather"].array![0]["icon"]
            let humidity = json["main"]["humidity"]
            let temperature = json["main"]["temp"]
        }
    }
    
    */
    @IBAction func registrationButton() {
        let alertView = SCLAlertView()
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        //ボタンの追加
        let alert = SCLAlertView(appearance: appearance)
        alertView.addButton("OK",backgroundColor: UIColor.rgba(red: 247, green: 204, blue: 215, alpha: 1.0)) {
            
            let object = NCMBObject(className: "SkinCondition")
            object?.setObject(self.temp1, forKey: "temp1")
            object?.setObject(self.temp2, forKey: "temp2")
            object?.setObject(self.temp3, forKey: "temp3")
            object?.setObject(self.temp4, forKey: "temp4")
            object?.setObject(self.temp5, forKey: "temp5")
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
        
      /*
        
        let object = NCMBObject(className: "SkinCondition")
        object?.setObject(temp1, forKey: "temp1")
        object?.setObject(temp2, forKey: "temp2")
        object?.setObject(temp3, forKey: "temp3")
        object?.setObject(temp4, forKey: "temp4")
        object?.setObject(temp5, forKey: "temp5")
        object?.setObject(NCMBUser.current(), forKey: "user")
        object?.saveInBackground({ (error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                SVProgressHUD.dismiss()
                let alertController = UIAlertController(title: "", message: "登録完了しました", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.tabBarController?.selectedIndex = 2
                })
                alertController.addAction(action)
                //ipadで必須
                alertController.popoverPresentationController?.sourceView = self.view
                let screenSize = UIScreen.main.bounds
                // ここで表示位置を調整
                // xは画面中央、yは画面下部になる様に指定
                alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    */
    
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
        
        let query = NCMBQuery(className: "SkinCondition")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: currentUser)
        query?.findObjectsInBackground({ (result, error) in
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
                
                self.slider1.value = Float(self.temp1)
                self.label1.text = String(self.temp1)
                self.slider2.value = Float(self.temp2)
                self.label2.text = String(self.temp2)
                self.slider3.value = Float(self.temp3)
                self.label3.text = String(self.temp3)
                self.slider4.value = Float(self.temp4)
                self.label4.text = String(self.temp4)
                self.slider5.value = Float(self.temp5)
                self.label5.text = String(self.temp5)
                }
            }
        })
        
    }
    
    
    
    
}
