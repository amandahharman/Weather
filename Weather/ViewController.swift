//
//  ViewController.swift
//  Weather
//
//  Created by Amanda Harman on 6/8/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var gainesville: Location = Location(cityName: "Gainesville", address: "606 SW 4th Ave", latitude: "29.648591", longitude: "-82.331251")
    var boston: Location = Location(cityName: "Boston", address: "51 Sawyer Rd #410", latitude: "42.361311", longitude: "-71.258547")
    
    var mobiquityOffices: [Location] = []
    var selectedCity: Location? = nil
    let weatherAPIKey = KeysManager.sharedInstance.WeatherAPIKey

    var resultArray = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mobiquityOffices += [gainesville, boston]
        if selectedCity != nil {
            cityNameLabel.text = selectedCity!.cityName
        }
        else {
            selectedCity = gainesville
            cityNameLabel.text = selectedCity!.cityName
        }

        
        Alamofire.request(.GET, "https://api.forecast.io/forecast/\(weatherAPIKey)/\(selectedCity!.latitude),\(selectedCity!.longitude)")
            .responseJSON {response in
                guard response.result.error == nil else {
                    print("error calling GET on /api/latitude/longitude")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    print(value["currently"]!!["temperature"])
                    let temp = value["currently"]!!["temperature"] as! Double
                    self.tempLabel.text = String(temp)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeLocationButtonPressed(sender: UIButton) {
    }
  

}

