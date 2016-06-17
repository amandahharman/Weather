//
//  ViewController.swift
//  Weather
//
//  Created by Amanda Harman on 6/8/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    var mobiquityOffices: [Location] = []
    var selectedCity: Location? = nil
    let weatherAPIKey = KeysManager.sharedInstance.WeatherAPIKey
    let locationURL = KeysManager.sharedInstance.mobLocation
    //    var locationDataArray = [[String: AnyObject]]()
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocations()
        picker.dataSource = self
        picker.delegate = self
        picker.hidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeLocationButtonPressed(sender: UIButton) {
        picker.hidden = false
    }
    
    func getWeather() {
        NetworkManager.sharedInstance.getData("https://api.forecast.io/forecast/\(weatherAPIKey)/\(selectedCity!.latitude),\(selectedCity!.longitude)"){result, error in
            if let value = result {
                let currentWeather = Weather(
                    temp: value["currently"]!!["temperature"] as! Int,
                    icon: value["currently"]!!["icon"] as! String)
                self.tempLabel.text = "\(currentWeather.temp)°F"
                self.weatherIconImageView.image = UIImage(named: "\(currentWeather.icon).png")!
            }
            else{
                print("Error fetching location data")
            }
        }
    }
    
    func getLocations(){
        NetworkManager.sharedInstance.getArrayOfData(locationURL) { (result, error) in
            if let  locationDataArray = result  {
                for cityInfo in locationDataArray{
                    self.mobiquityOffices.append(Location(
                        id: cityInfo["id"] as! Int,
                        name: cityInfo["cityName"] as! String,
                        address: cityInfo["address"] as! String,
                        latitude: cityInfo["latitude"] as! String,
                        longitude: cityInfo["longitude"] as! String))
                }
                self.selectedCity = self.mobiquityOffices.first
                self.cityNameLabel.text = self.selectedCity!.name
                self.getWeather()
                self.picker.reloadAllComponents()
            }
            else {
                print("Error fetching location data")
            }
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mobiquityOffices.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mobiquityOffices[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(mobiquityOffices[row].name)
        selectedCity = mobiquityOffices[row]
        picker.hidden = true
        cityNameLabel.text = selectedCity?.name
        getWeather()
        
    }
}


