//
//  FoundationListViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/03.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import SDWebImage
import TTTAttributedLabel
import  NCMB
import SVProgressHUD

class FoundationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FoundationTableViewCellDelegate {
    
    @IBOutlet weak var foundationListTableView: UITableView!
    
    var passedSkin1 = 3
    var passedSkin2 = 3
    var passedSkin3 = 3
    var passedSkin4 = 3
    var passedSkin5 = 3
    
    var passedSkinState = [Int]()
    var selectedBrand = [String]()
    var brandNumber = 0
    
    
  //  var selectedCategory: String = ""
    //var selectedSeason: String = ""
    var selectedIndex: Int = 0
    var foundationArray: [Foundation] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseBrand()

        foundationListTableView.dataSource = self
        foundationListTableView.delegate = self
        
        let nib = UINib(nibName: "FoundationTableViewCell", bundle: Bundle.main)
        foundationListTableView.register(nib, forCellReuseIdentifier: "foundationCell")
        
        foundationListTableView.rowHeight = 380.0
        foundationListTableView.tableFooterView = UIView()
        
        loadCosmetics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chooseBrand() {
        if ((passedSkin1 + passedSkin2) < 7){
            selectedBrand = [/*"e.l.f.",*/"pure anada","dr. hauschka","physicians formula","mineral fusion","sante","marcelle","marienatie","rejuva minerals","w3llpeople","deciem"]
        } else if ((passedSkin1 + passedSkin2) > 6) {
            if ((passedSkin3 + passedSkin5) > 6){
                if ((passedSkin4) < 3) {
                    selectedBrand = ["benefit","dior","smashbox","clinique"]
                }else {
                    selectedBrand = [/*"e.l.f",*/"pure anada","dr. hauschka","physicians formula","mineral fusion","sante","marcelle","marienatie","rejuva minerals","w3llpeople","deciem","benefit","dior","smashbox","clinique","maybelline","revlon","l'oreal","nyx","colourpop","covergirl","almay","annabelle","cargo cosmetics","milani","iman","fenty","glossier"]
                }
            }else {
                selectedBrand = ["maybelline","revlon","l'oreal"]
            }
        }
    }
    
    

    func loadCosmetics() {
        SVProgressHUD.show()
        for brandName in selectedBrand{
            MakeUpAPI.getCosmeticsFromTypeAndBrand(brand: brandName) { (results, success) in
            if success == false {
                //エラー
            } else {
                //成功
                for result in results {
                    let productName = result["name"] as! String
                    if let productDescription = result["description"] as? String {
                        if let productPrice = result["price"] as? String {
                            let productBrand = result["brand"] as? String
                            let productType = result["product_type"] as! String
                            let imageUrl = result["image_link"] as! String
                            let webUrl = result["product_link"] as! String
                            let foundation = Foundation(productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand!,productType: productType,  productImageUrl: imageUrl, productWebUrl: webUrl)
                            let query = NCMBQuery(className: "like")
                            query?.includeKey("user")
                            query?.whereKey("user",equalTo:NCMBUser.current())
                            query?.findObjectsInBackground({ (result, error) in
                                if error != nil {
                                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                                    print("読み込み失敗")
                                }else{
                                    for like in result as! [NCMBObject]{
                                        if (( foundation.productImageUrl == like.object(forKey: "likeimage") as! String) || (foundation.productWebUrl == like.object(forKey: "productWebUrl") as! String) ){
                                            foundation.isLiked = true
                                        }
                                    }
                                }
                            })
                            self.foundationArray.append(foundation)
                        }}
                            DispatchQueue.main.async {
                                SVProgressHUD.dismiss()
                                self.foundationListTableView.reloadData()
                    }}}}}}
                        
                            /*let productType = result["product_type"] as! String
                            let productColors = result["product_colors"] as! [NSDictionary]
                            for productColor in productColors {
                                if let color = productColor["hex_value"] as? String {
                                   HexValueToRGB.hexValueToRGB(hexValue: color, complition: { (red, blue, green) in
                                        HexValueToRGB.rangeJudge(category: self.switchCategory(selectedCategory: self.selectedCategory)!, season: self.selectedSeason, red: red, green: green, blue: blue, complition: { (success) in
                                            if success == true {
                                                if let productBrand = result["brand"] as? String {
                                                    let imageUrl = result["image_link"] as! String
                                                    let webUrl = result["product_link"] as! String
                                                    let cosme = Cosme(productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl, productWebUrl: webUrl)
                                                    self.cosmeArray.append(cosme)
                                                }
                                            }
                                        })
                                    })
                                }
                                
                                DispatchQueue.main.async {
                                    self.cosmeListTableView.reloadData()
                                }}}}}}*/
    
   
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel) {
        self.selectedIndex = tableViewCell.tag
        self.performSegue(withIdentifier: "toWeb", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundationArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foundationCell") as! FoundationTableViewCell
        
        cell.delegate = self /*as? FoundationTableViewCellDelegate*/
        cell.tag = indexPath.row
        
        cell.productNameLabel.text = foundationArray[indexPath.row].productName
        cell.productDescriptionTextView.text = foundationArray[indexPath.row].productDescription
        //cell.productTypeLabel.text = foundationArray[indexPath.row].productType
        cell.productBrandLabel.text = foundationArray[indexPath.row].productBrand
        cell.productPriceLabel.text = foundationArray[indexPath.row].productPrice
        cell.productImageView.sd_setImage(with: URL(string: foundationArray[indexPath.row].productImageUrl), completed: nil)
        cell.productWebUrlLabel.text = foundationArray[indexPath.row].productWebUrl
        
      
        // Likeによってハートの表示を変える（お気に入り登録）
        if foundationArray[indexPath.row].isLiked == true {
            cell.likeButton.setImage(UIImage(named: "like.png"), for: .normal)
            //print("::::::::::::")
        } else {
            cell.likeButton.setImage(UIImage(named: "unlike.png"), for: .normal)
            //print("******************")
        }
      
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let explainWebViewController = segue.destination as! ExplainWebViewController
        let selectedIndex = self.selectedIndex
        explainWebViewController.url = foundationArray[selectedIndex].productWebUrl
    }
    
    //お気に入り登録
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton) {
        
        
        if  foundationArray[tableViewCell.tag].isLiked == false || foundationArray[tableViewCell.tag].isLiked == nil {
            foundationArray[tableViewCell.tag].isLiked = true
            //print("--------------------------------------")
            let object = NCMBObject(className: "like")
            object?.setObject(foundationArray[tableViewCell.tag].productImageUrl,forKey: "likeimage")
            object?.setObject(foundationArray[tableViewCell.tag].productName,forKey: "productName")
            object?.setObject(foundationArray[tableViewCell.tag].productPrice,forKey: "productPrice")
            object?.setObject(foundationArray[tableViewCell.tag].productBrand,forKey: "productBrand")
            object?.setObject(foundationArray[tableViewCell.tag].productWebUrl,forKey: "productWebUrl")
            object?.setObject(foundationArray[tableViewCell.tag].productType,forKey: "productType")
            object?.setObject(NCMBUser.current(),forKey: "user")
            object?.saveInBackground({(error) in
                if error != nil{
                    //エラーが発生したら
                    print("保存に失敗しました")
                    
                }else{
                    //保存に成功したら
                    print("保存に成功しました")
                }
            })
        }else{
            foundationArray[tableViewCell.tag].isLiked = false
            /*guard let currentUser = NCMBUser.current() else {
             //ログアウト成功
             let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
             let rootViewcontroller = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
             UIApplication.shared.keyWindow?.rootViewController = rootViewcontroller
             //ログイン状態の保持
             let ud = UserDefaults.standard
             ud.set(false, forKey: "isLogin")
             ud.synchronize()
             return
             }*/
            let query = NCMBQuery(className: "like")
            query?.whereKey("user",equalTo:NCMBUser.current())
            query?.whereKey("productWebUrl",equalTo:foundationArray[tableViewCell.tag].productWebUrl)
            query?.findObjectsInBackground({ (result, error) in
                if error != nil {
                    print("削除するものがありません")
                } else{
                    let unlike = result as! [NCMBObject]
                    let unlike2 = unlike.first
                    unlike2?.deleteInBackground({(error) in
                        if error != nil{
                            print("削除に失敗しました")
                        }else{
                            print("削除に成功しました")
                        }
                    })
                }
            })
        }
        self.foundationListTableView.reloadData()
    }

    
}
