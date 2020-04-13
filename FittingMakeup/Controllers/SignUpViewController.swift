//
//  SignUpViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/12.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB

class SignUpViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField :UITextField!
    @IBOutlet var confirmTextField : UITextField!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)

        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUp(){
        let user = NCMBUser()
        
        if (userIdTextField.text?.characters.count)! < 4  {
            print("文字数が足りません")
            return
        }
        user.userName = userIdTextField.text!
        user.mailAddress = emailTextField.text!
        
        if passwordTextField.text == confirmTextField.text {
            user.password = passwordTextField.text!
        }else{
            print("パスワードが間違っています")
        }
        user.signUpInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
        }
        
}
}
