//
//  SignInViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/12.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var button : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 5.0
        
        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func signIn(){
        
        if (userIdTextField.text?.characters.count)! > 0 && (passwordTextField.text?.characters.count)! > 0 {
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) {(user,error) in
                if error != nil {
                    print(error)
                } else{
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
    
}
