//
//  NetworkManager.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 15/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let instance = NetworkManager()
    
    struct Ctx {
        static let baseUrl = "https://dkt.lorispinna.com/"
        
        struct Resources {
            static let jsonFile = "format.json"
        }
        
        static let jsonFile = baseUrl + Resources.jsonFile
        
        static func getFile(name:String)->String {
            return "\(self.baseUrl)\(name).json"
        }
    }
    
    func getValueAt(url: String, callback: @escaping (String?) -> Void) {
        guard url.isURL() else {
            callback("The given URL " + url + " is not valid")
            
            return
        }
        
        request(url).responseString { (res) in
            callback(res.result.value)
        }
    }
    
    func getJSONValueAt<T: Decodable>(url: String, callback: @escaping (T?) -> Void) -> Void {
        guard url.isURL() else {
            print("Bad URL")
            return
        }
        
        request(url).responseJSON { (res) in
            let decoder = JSONDecoder()
            
            guard let data = res.data else {
                print("No Data")
                return
            }
            
            let _ = String(data: data, encoding: String.Encoding.utf8)
            
            do {
                let decoded = try decoder.decode(T.self, from: data)
                
                callback(decoded)
            } catch {
                print("Failed Decode : ")
                print(error)
            }
            
        }
    }
    
    
    func getJson(name: String, callback: @escaping (NodeObject?) -> Void) {
        getJSONValueAt(url: Ctx.getFile(name: name), callback: callback)
    }
    
}
