//
//  NetworkManager.swift
//  Weather
//
//  Created by Amanda Harman on 6/15/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    func getData(endpoint: String, completion: (result: AnyObject?, error: NSError?) -> ()) {
        Alamofire.request(.GET, endpoint)
            .responseJSON {response in
                if let error = response.result.error  {
                    print("Error getting data: \(error)")
                    completion(result: nil, error: NSError(domain: "com.weather", code: 1000, userInfo: nil))
                }
                if let value = response.result.value {
                    completion(result: value, error: nil)
                }
                else {
                    completion(result: nil, error: NSError(domain: "com.weather", code: 1000, userInfo: nil))
                }
        }
    }
    
    func getArrayOfData(endpoint: String, completion: (result: [[String:AnyObject]]?, error: NSError?) -> ()) {
        
        var arrayOfResults = [[String:AnyObject]]()
        
        Alamofire.request(.GET, endpoint)
            .responseJSON {response in
                
                if let error = response.result.error {
                    print("Error calling GET. Returned :\(error)")
                    completion(result: nil , error: NSError(domain: "com.whoapp", code: 1000, userInfo: nil))
                }
                
                if let value = response.result.value {
                    if let resultData = JSON(value).arrayObject {
                        arrayOfResults = resultData as! [[String : AnyObject]]
                        completion(result: arrayOfResults, error: nil)
                    } else {
                        completion(result: nil, error: NSError(domain: "com.whoapp", code: 1000, userInfo: nil))
                    }
                }
        }
    }
}