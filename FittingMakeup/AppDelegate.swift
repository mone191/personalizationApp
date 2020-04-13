//
//  AppDelegate.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/07/03.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        NCMB.setApplicationKey("3f7dabe3464cf3550697f82b4c78d7abbe1aa3f33d1552984d6312af5cf49ad4", clientKey: "663d5fdbc0dd2b8548765422ae3553bf95999cbab97d277ca7d5f60e02d5cc2c")
        
        
        let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isLogin")
       
        if isLogin == true{
            
           
            //ログイン中だったら
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle:Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootTabBarController" )
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            
          
            
        }else{
            //ログインしてなかったら
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "SignIn", bundle:Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier:"RootNavigationController" )
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        }
        
        // ナビゲーションバーの色変更
        UINavigationBar.appearance().barTintColor = UIColor.makeUpPink
        //tabbarの選択された時の色の変更
        UITabBar.appearance().tintColor = UIColor.darkGray
 
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
  


}

