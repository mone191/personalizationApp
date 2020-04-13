//
//  MakeUpAPI.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct MakeUpAPI {
    
    static let baseUrl = "https://makeup-api.herokuapp.com/api/v1/products"
    
    
    //全部のデータを取得する。
    static func getAllCosmetics(complition: @escaping ([[String: Any]], Bool) -> Swift.Void) {
        let session = URLSession.shared
        
        let path = "\(baseUrl).json?"
        let url = URL(string: path)!
        
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let cosmetics = json.map({ (cosme) -> [String: Any] in
                    return cosme as! [String: Any]
                })
                complition(cosmetics, true)
            } catch {
                //エラー
            }
        }
        
        
        dataTask.resume()
    }
    
    //ブランドからデータを取ってくる
    static func getCosmeticsFromBrand(brand: String, complition: @escaping ([[String: Any]], Bool) -> Swift.Void) {
        let session = URLSession.shared
        
        let path = "\(baseUrl).json?brand=\(brand)"
        let url = URL(string: path)!
        
        
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let cosmetics = json.map({ (cosme) -> [String: Any] in
                    return cosme as! [String: Any]
                })
                complition(cosmetics, true)
            } catch {
                //エラー
            }
        }
        
        
        dataTask.resume()
    }
    
    //プロダクトタイプからデータを取ってくる
    static func getCosmeticsFromProductType(productType: String, complition: @escaping ([[String: Any]], Bool) -> Swift.Void) {
        let session = URLSession.shared
        
        let path = "\(baseUrl).json?product_type=\(productType)"
        let url = URL(string: path)!
        
        
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let cosmetics = json.map({ (cosme) -> [String: Any] in
                    return cosme as! [String: Any]
                })
                complition(cosmetics, true)
            } catch {
                //エラー
            }
        }
        
        
        dataTask.resume()
    }
    
    
    //ブランドからファンデのデータを取ってくる
    static func getCosmeticsFromTypeAndBrand(brand:String, complition: @escaping ([[String: Any]], Bool) -> Swift.Void) {
        let session = URLSession.shared
        
        let path = "\(baseUrl).json?brand=\(brand)&product_type=foundation"
        print("パスは")
        print(path)
        guard let url = URL(string: path) else {return}
        print("urlは")
        print(url)
        
        
        
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                let cosmetics = json.map({ (cosme) -> [String: Any] in
                    return cosme as! [String: Any]
                })
                complition(cosmetics, true)
            } catch {
                //エラー
            }
        }
        
        
        dataTask.resume()
    }
    
}


