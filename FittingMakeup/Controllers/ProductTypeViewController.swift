//
//  ProductTypeViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB
import SVProgressHUD

class ProductTypeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
  
    
    var temp1 : Int = 3
    var temp2 : Int = 3
    var temp3 : Int = 3
    var temp4 : Int = 3
    var temp5 : Int = 3
    
    
    @IBOutlet weak var productTypeTableView: UITableView!
    
    var productTypeNameArray: [String] = ["アイシャドウ", "リップ","チーク", /*"ブロンザー", "アイブロウ", "アイライナー", */"ファンデーション"/*"リップライナー"/, "マスカラ", "ネイル"*/]
    
    var productImageArray : [String]  = ["アイシャドウ１.png","リップ.png","チーク１.png","ファンデ１.png"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTypeTableView.dataSource = self
        productTypeTableView.delegate = self
        
        let nib = UINib(nibName: "ProductTypeTableViewCell", bundle: Bundle.main)
        productTypeTableView.register(nib, forCellReuseIdentifier: "productTypeCell")
        
        productTypeTableView.tableFooterView = UIView()
        productTypeTableView.rowHeight = 60
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if (indexPath.row ==
            0 || indexPath.row == 1 || indexPath.row == 2) {
        self.performSegue(withIdentifier: "toSeasonSelectViewController", sender: nil)
       tableView.deselectRow(at: indexPath, animated: true)
        } else {
            self.performSegue(withIdentifier: "toFoundation", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
         tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productTypeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTypeCell") as! ProductTypeTableViewCell
        cell.productTypeNameLabel.text = productTypeNameArray[indexPath.row]
        cell.iconImageView.image = UIImage(named: productImageArray[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            // identifierが取れなかったら処理やめる
            return
        }
        if (identifier == "toSeasonSelectViewController") {
         let selectSeasonViewController = segue.destination as! SelectSeasonViewController
         let selectedIndexPath = productTypeTableView.indexPathForSelectedRow!
        selectSeasonViewController.selectedCategory = productTypeNameArray[selectedIndexPath.row]
        } else if (identifier == "toFoundation") {
        //次の画面を取得（次の画面のオブジェクトを取得する）
            let FoundationListViewController = segue.destination as! FoundationListViewController
            //肌状態の受け渡し
            FoundationListViewController.passedSkin1 = self.temp1
            FoundationListViewController.passedSkin2 = self.temp2
            FoundationListViewController.passedSkin3 = self.temp3
            FoundationListViewController.passedSkin4 = self.temp4
            FoundationListViewController.passedSkin5 = self.temp5
        } else {}
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
             
              
            }
        })
}
   
}
