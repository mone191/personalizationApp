//
//  SelectSeasonViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit

class SelectSeasonViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var seasonTableView: UITableView!
    var productImageArray : [String]  = ["spring.jpg","summer.jpg","autumn.jpg","winter.jpg"]
    
    var season = ["春タイプ", "夏タイプ", "秋タイプ", "冬タイプ"]
    var selectedCategory: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        seasonTableView.delegate = self
        seasonTableView.dataSource = self
        
        seasonTableView.tableFooterView = UIView()
        seasonTableView.rowHeight = 120
        
        let nib = UINib(nibName: "ProductTypeTableViewCell", bundle: Bundle.main)
        seasonTableView.register(nib, forCellReuseIdentifier: "productTypeCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  season.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTypeCell") as! ProductTypeTableViewCell
        cell.productTypeNameLabel.text = season[indexPath.row]
        cell.iconImageView.image = UIImage(named: productImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toCosmeListViewController", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cosmeListViewController = segue.destination as! CosmeListViewController
        let selectedIndex = seasonTableView.indexPathForSelectedRow!
        cosmeListViewController.selectedCategory = self.selectedCategory
        if season[selectedIndex.row] == "春タイプ"{
            cosmeListViewController.selectedSeason = "spring"
        } else if season[selectedIndex.row] == "夏タイプ"{
             cosmeListViewController.selectedSeason = "summer"
        } else if season[selectedIndex.row] == "秋タイプ"{
             cosmeListViewController.selectedSeason = "autumn"
        } else {
            cosmeListViewController.selectedSeason = "winter"
        }
    }
}
