//
//  LikeListViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/08.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import  NCMB
import SVProgressHUD

class LikeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LikeTableViewCellDelegate  {

    @IBOutlet weak var likeListTableView: UITableView!
    var selectedIndex: Int = 0
    var likeArray = [Like]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        likeListTableView.dataSource = self
        likeListTableView.delegate = self
        
        let nib = UINib(nibName: "LikeTableViewCell", bundle: Bundle.main)
        likeListTableView.register(nib, forCellReuseIdentifier: "likeCell")
        
        likeListTableView.rowHeight = 320.0
        likeListTableView.tableFooterView = UIView()
       //LoadLike()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        LoadLike()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadLike(){
        let query = NCMBQuery(className: "like")
         query?.includeKey("user")
        query?.whereKey("user",equalTo:NCMBUser.current())
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
                print("読み込み失敗")
            }else{
                   self.likeArray.removeAll()
                for like in result as! [NCMBObject]{
                let productName = like.object(forKey: "productName") as! String
                let productBrand = like.object(forKey: "productBrand") as! String
                let productPrice = like.object(forKey: "productPrice") as! String
                let productType = like.object(forKey: "productType") as! String
                let productImageUrl = like.object(forKey: "likeimage") as! String
                let productWebUrl = like.object(forKey: "productWebUrl") as! String
                let likepart = Like(productName: productName, productPrice: productPrice, productBrand: productBrand, productType: productType, productImageUrl: productImageUrl, productWebUrl: productWebUrl)
                 
                self.likeArray.append(likepart)
                DispatchQueue.main.async {
                        self.likeListTableView.reloadData()
                }
            }
            }
        })
    }
    
    func didTapLink(tableViewCell: UITableViewCell, label: TTTAttributedLabel) {
        self.selectedIndex = tableViewCell.tag
        self.performSegue(withIdentifier: "toLikeWeb", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likeCell") as! LikeTableViewCell
        
        cell.delegate = self
        cell.tag = indexPath.row
        
        cell.productNameLabel.text = likeArray[indexPath.row].productName
        //cell.productDescriptionTextView.text = likeArray[indexPath.row].productDescription
        cell.productTypeLabel.text = likeArray[indexPath.row].productType
        cell.productBrandLabel.text = likeArray[indexPath.row].productBrand
        cell.productPriceLabel.text = likeArray[indexPath.row].productPrice
        cell.productImageView.sd_setImage(with: URL(string: likeArray[indexPath.row].productImageUrl), completed: nil)
        cell.productWebUrlLabel.text = likeArray[indexPath.row].productWebUrl
       
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let explainWebViewController = segue.destination as! LikeWebViewController
        let selectedIndex = self.selectedIndex
        explainWebViewController.url = likeArray[selectedIndex].productWebUrl
    }
}
