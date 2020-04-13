//
//  CosmeListViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import SDWebImage
import TTTAttributedLabel
import  NCMB
import SVProgressHUD

class CosmeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CosmeTableViewCellDelegate  {
    
    @IBOutlet weak var cosmeListTableView: UITableView!
    
    var selectedCategory: String = ""
    var selectedSeason: String = ""
    var selectedIndex: Int = 0
    var cosmeArray: [Cosme] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        cosmeListTableView.dataSource = self
        cosmeListTableView.delegate = self
        
        let nib = UINib(nibName: "CosmeTableViewCell", bundle: Bundle.main)
        cosmeListTableView.register(nib, forCellReuseIdentifier: "cosmeCell")
        
        cosmeListTableView.rowHeight = 380.0
        cosmeListTableView.tableFooterView = UIView()
        
        loadCosmetics(category: self.switchCategory(selectedCategory: selectedCategory)!)
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func switchCategory(selectedCategory: String) -> String? {
        switch selectedCategory {
        case "チーク":
            return productType.blush.rawValue
        case "ブロンザー":
            return productType.bronzer.rawValue
        case "アイブロウ":
            return productType.eyebrow.rawValue
        case "アイライナー":
            return productType.eyeliner.rawValue
        case "アイシャドウ" :
            return productType.eyeshadow.rawValue
        case "ファンデーション":
            return productType.foundation.rawValue
        case "リップライナー":
            return productType.lip_liner.rawValue
        case "リップ":
            return productType.lipstick.rawValue
        case "マスカラ":
            return productType.mascara.rawValue
       /* case "":
            return productType.nail_polish.rawValue*/
        default:
            return nil
        }
    }
    
   
    
    func loadCosmetics(category: String) {
        SVProgressHUD.show()
        MakeUpAPI.getCosmeticsFromProductType(productType: category) { (results, success) in
            if success == false {
                //エラー
            } else {
                //成功
                for result in results {
                    let productName = result["name"] as! String
                    if let productDescription = result["description"] as? String {
                        if let productPrice = result["price"] as? String {
                            let productType = result["product_type"] as! String
                            let productColors = result["product_colors"] as! [NSDictionary]
                            for productColor in productColors {
                                if let color = productColor["hex_value"] as? String {
                                    HexValueToRGB.hexValueToRGB(hexValue: color, complition: { (red, blue, green) in
                                        HexValueToRGB.rangeJudge(category: self.switchCategory(selectedCategory: self.selectedCategory)!, season: self.selectedSeason, red: red, green: green, blue: blue, complition: { (success) in
                                            if success == true {
                                                if let productBrand = result["brand"] as? String {
                                                    let imageUrl = result["image_link"] as! String
                                                    let webUrl = result["product_link"] as! String
                                                    let cosme = Cosme( productName: productName, productDescription: productDescription, productPrice: productPrice, productBrand: productBrand, productType: productType, productColor: color, productImageUrl: imageUrl, productWebUrl: webUrl)
                                                    let query = NCMBQuery(className: "like")
                                                    query?.includeKey("user")
                                                    query?.whereKey("user",equalTo:NCMBUser.current())
                                                    query?.findObjectsInBackground({ (result, error) in
                                                        if error != nil {
                                                            SVProgressHUD.showError(withStatus: error!.localizedDescription)
                                                            print("読み込み失敗")
                                                        }else{
                                                            for like in result as! [NCMBObject]{
                                                                if (( cosme.productImageUrl == like.object(forKey: "likeimage") as! String) || (cosme.productWebUrl == like.object(forKey: "productWebUrl") as! String) ){
                                                                    cosme.isLiked = true
                                                                }
                                                                }
                                                            }
                                                        })
                                                    self.cosmeArray.append(cosme)
                                                    
                                                }
                                            }
                                        })
                                    })
                                }
                                
                                DispatchQueue.main.async {
                                    SVProgressHUD.dismiss()
                                    self.cosmeListTableView.reloadData()
                                }
                            }
                            
                        }
                        
                    }
                }
            }
        }
       
    }
    
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel) {
        self.selectedIndex = tableViewCell.tag
        self.performSegue(withIdentifier: "toNextController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmeArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cosmeCell") as! CosmeTableViewCell
        
        cell.delegate = self
        cell.tag = indexPath.row
        
        cell.productNameLabel.text = cosmeArray[indexPath.row].productName
        cell.productDescriptionTextView.text = cosmeArray[indexPath.row].productDescription
        cell.productTypeLabel.text = cosmeArray[indexPath.row].productType
        cell.productBrandLabel.text = cosmeArray[indexPath.row].productBrand
        cell.productPriceLabel.text = cosmeArray[indexPath.row].productPrice
        cell.productImageView.sd_setImage(with: URL(string: cosmeArray[indexPath.row].productImageUrl), completed: nil)
        cell.productWebUrlLabel.text = cosmeArray[indexPath.row].productWebUrl
        
        HexValueToRGB.hexValueToRGB(hexValue: cosmeArray[indexPath.row].productColor) { (red, blue, green) in
            cell.productColorLabel.text = "\(red),\(blue),\(green)"
        }
        
        // Likeによってハートの表示を変える（お気に入り登録）
        if cosmeArray[indexPath.row].isLiked == true {
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
        explainWebViewController.url = cosmeArray[selectedIndex].productWebUrl
    }
  
    //お気に入り登録
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton) {
        
      
        if  cosmeArray[tableViewCell.tag].isLiked == false || cosmeArray[tableViewCell.tag].isLiked == nil {
            cosmeArray[tableViewCell.tag].isLiked = true
            //print("--------------------------------------")
            let object = NCMBObject(className: "like")
            object?.setObject(cosmeArray[tableViewCell.tag].productImageUrl,forKey: "likeimage")
            object?.setObject(cosmeArray[tableViewCell.tag].productName,forKey: "productName")
            object?.setObject(cosmeArray[tableViewCell.tag].productPrice,forKey: "productPrice")
            object?.setObject(cosmeArray[tableViewCell.tag].productBrand,forKey: "productBrand")
            object?.setObject(cosmeArray[tableViewCell.tag].productWebUrl,forKey: "productWebUrl")
            object?.setObject(cosmeArray[tableViewCell.tag].productType,forKey: "productType")
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
            cosmeArray[tableViewCell.tag].isLiked = false
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
            query?.whereKey("productWebUrl",equalTo:cosmeArray[tableViewCell.tag].productWebUrl)
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
        self.cosmeListTableView.reloadData()
    }

    

}
