//
//  P8ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/01.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import  NCMB
import SVProgressHUD

class P8ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
  
    
    @IBOutlet var sampleCollectionView: UICollectionView!
    var imageArray = ["JillEye.png","JillFound.png","NarsCheek.png","YSLLip.png","YSLBase.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleCollectionView.dataSource = self
        sampleCollectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    //セルに表示される処理
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cellの登録
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //imageViewとセルの結びつけ
        let sampleView = cell.viewWithTag(1) as! UIImageView
        sampleView.image = UIImage(named: imageArray[indexPath.row])
        
        return cell
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    //storyboradでimageviewmの制約とcell間の余白の調整が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize:CGFloat = self.view.bounds.width/3
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // UICollectionViewの外周余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 行の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // 列の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    //選択されたセルの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toNext", sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! P9ViewController
        let selectedIndex = sampleCollectionView.indexPathsForSelectedItems![0]
        nextViewController.selectedName = imageArray[selectedIndex.row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
