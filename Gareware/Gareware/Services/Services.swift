//
//  Services.swift
//  Gareware
//
//  Created by Gopakumar MP on 7/1/19.
//  Copyright © 2019 Gopakumar MP. All rights reserved.
//

import UIKit

class Services: NSObject {
    static let instance = Services()
    
    override init() {
        super.init()
    }
    
    func addNewNewUser(name: String, email: String, completionHandler: @escaping (Error?) -> Void) {
        
        var dict = [String:String]()
        dict["CustomerName"] = name
        dict["Email"] = email
        dict["DeviceID"] = UIDevice.current.identifierForVendor?.uuidString
        dict["Platform"] = "iOS"
        dict["AppName"] = "GarewareIndia_iOS"
        
        guard let url = URL(string: kAddCustomerURL) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        request.httpBody =  try? JSONSerialization.data(withJSONObject: dict)
        request.httpMethod = "POST"
        let loginData = String(format: "%@:%@", kLogin, kCode).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            print(response ?? "")
            
            guard let data  = data else {
                return
            }
            
            if let err = error {
                completionHandler(err)
            }
            
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let customer = jsonObj["Customer"] as? [String:Any], let status = customer["Status"] as? String, status == "Success" {
                        completionHandler(nil)
                    } else {
                        let err = NSError(domain: "Failed to Register", code: 1002)
                        completionHandler(err)
                        
                    }
                }
            } catch {
                let err = NSError(domain: "JSON Error", code: 1000)
                completionHandler(err)
            }
            
            print(data)
        }
        
        task.resume()
    }
    
    func getAppVersion(completionHandler: @escaping (String?, Error?) -> Void) {
        var dict = [String:String]()
        dict["Platform"] = "iOS"
        dict["AppName"] = "GarewareIndia_iOS"
        
        guard let url = URL(string: kFetchAppVersionURL) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        request.httpBody =  try? JSONSerialization.data(withJSONObject: dict)
        request.httpMethod = "GET"
        let loginData = String(format: "%@:%@", kLogin, kCode).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            guard let data = data else {
                return
            }
            
            if let err = error {
                completionHandler(nil,err)
            }
            
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let obj = jsonObj["Status"] as? String,obj == "Success" {
                        completionHandler(obj,nil)
                    }
                }
            } catch {
                let err = NSError(domain: "JSON Error", code: 1000)
                completionHandler(nil,err)
            }
        }
        
        task.resume()
    }
    
    func fetchFilmDetails(completionHandler: @escaping (Error?) -> Void) {
        var dict = [String:String]()
        dict["AppType"] = "Local"
        
        guard let url = URL(string: kFetchFilmDetailsURL) else {
            return
        }
        let request = NSMutableURLRequest(url: url)
        request.httpBody =  try? JSONSerialization.data(withJSONObject: dict)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let loginData = String(format: "%@:%@", kLogin, kCode).data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            guard let data = data else {
                return
            }
            
            if let err = error {
                completionHandler(err)
            }
            
            do {
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Get application document directory path array
                    let dict  = NSMutableDictionary(dictionary: jsonObj)
                    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
                    
                    if let documentPath = paths.first {
                        let filePath = NSMutableString(string: documentPath).appendingPathComponent(kFilmDetailsFileName).appending("txt")
                        
                        let URL = NSURL.fileURL(withPath: filePath)
                        let success = dict.write(to: URL, atomically: true)
                        print("write: ", success);
                        completionHandler(nil)
                    }
                }
            } catch {
                let err = NSError(domain: "JSON Error", code: 1000)
                completionHandler(err)
            }
        }
        
        task.resume()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
