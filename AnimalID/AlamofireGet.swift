//
//  alamofireGet.swift
//
//
//  Created by Nazar on 07.04.17.
//
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamGet {
    
    public var keyFromDefault = UserDefaults.standard
    
    func getLogin(login: String, password: String) -> Bool {
        // let group = DispatchGroup()
        keyFromDefault.removeObject(forKey: "key")
        var flag = false
        let x = "\(login):\(password)"
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(x.base64Encoded()!))",
            "Accept": "application/json"
        ]
        //        let queue = DispatchQueue(label: "com.allaboutswift.dispatchgroup", attributes: .concurrent, target: .main)
        //        let group = DispatchGroup()
        //
        //
        //        group.enter()
        //        queue.async (group: group) {
        //            print("doing more stuff again ")
        //            group.leave()
        //        }
        //        group.notify(queue: DispatchQueue.main) {
        //            print("done doing stuff again")
        //        }
        
        //print("___________1----------------")
        //DispatchQueue.main.async {
        //        group.enter()
        //        queue.async (group: group) {
        Alamofire.request("http://api.animal-id.info/homeless_v1/auth/login", method: .get, headers: headers).responseJSON { response in
            guard let jsonDict = response.result.value as? [String : Any]
                else { return }
            
            let myData = JSON(jsonDict)
            if let data = myData["data"]["auth_key"].string
            {
                
                // MARK: -user default
                self.keyFromDefault.setValue(data, forKey: "key")
                flag = true
                // print("daaaaaata: ", data)
                //print("may new key", self.keyFromDefault.string(forKey: "key") ?? "0000000000000000")
                print("if get auth_key: ", flag)
            }
            //print("___________6----------------")
            
            if let startTime = myData["data"]["active_counting"]["start_time"].int {
                self.keyFromDefault.setValue(startTime, forKey: "startTime")
                // print("Start time : ", startTime)
                //print("___________7----------------")
                
            }
            if let endTime = myData["data"]["active_counting"]["end_time"].int {
                self.keyFromDefault.setValue(endTime, forKey: "endTime")
                
            }
            
            if let startTime = myData["data"]["next_counting"]["start_time"].int {
                self.keyFromDefault.setValue(startTime, forKey: "startTime")
                //print("Startxgdgd sfhd time : ", startTime)
                
            }
            if let endTime = myData["data"]["next_counting"]["end_time"].int {
                self.keyFromDefault.setValue(endTime, forKey: "endTime")
                //print("End sdgsdg time : ", endTime)
            }
            if let titleName = myData["data"]["active_counting"]["title"].string {
                self.keyFromDefault.setValue(titleName, forKey: "titleName")
                //print("titleName   : ", titleName)
            }
//            group.leave()
            //            }
            print("___________9----------------")
        }
        
        print("___________10----------------")
        //group.wait()
        print("end func: ", flag)
        return true
    }
    
    func getLogout() {
        if let key = keyFromDefault.string(forKey: "key") {
            print(key)
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(key)",
                "Accept": "application/json"
            ]
            
            Alamofire.request("http://api.animal-id.info/homeless_v1/auth/logout", method: .post , headers: headers).responseJSON { response in
                // debugPrint(response)
                
                guard let jsonDict = response.result.value as? [String : Any]
                    else { return }
                
                let myData = JSON(jsonDict)
                if let data = myData["data"].bool
                {
                    // MARK: -user default
                    print("daaaaaata: ", data)
                }
            }
        }
        
    }
}

extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}






































