//
//  KeysManager.swift
//  Weather
//
//  Created by Amanda Harman on 6/8/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation

class KeysManager {
    
    static let sharedInstance = KeysManager()
    
    var WeatherAPIKey: String {
        get {
            guard let filePath = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist") else {
                print("File not found!")
                return "NO_KEY"
            }
            guard let keys = NSDictionary(contentsOfFile: filePath) else {
                print("Could not get dictionary from file")
                return "NO_KEY"
            }
            guard let weatherAPIKey = keys.objectForKey("WeatherAPIKey") as? String  else {
                print("Could not find value for your key...")
                return "NO_KEY"
            }
            return weatherAPIKey
        }
    }

}