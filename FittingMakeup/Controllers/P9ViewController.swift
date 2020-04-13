//
//  P9ViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/01.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit

class P9ViewController: UIViewController {
    
    var selectedName: String!
    @IBOutlet var imageview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.image = UIImage(named: selectedName!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
