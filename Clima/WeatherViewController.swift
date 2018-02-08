//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // Location n stuffs
import Alamofire // HTTP Request
import SwiftyJSON // Parse JSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "a66437ed6ae996440e8cddee3fdc6749"
    
    
    //TODO: Declare instance variables here
    // 1.(Location)
    let locationManager = CLLocationManager()
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        // 2. (Location) here we set WeatherViewController as "delegate" of CLLocationManager, so our viewController
        // can get data (lat,long,etc) from the CLLocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization() // notif for permission to use location
        locationManager.startUpdatingLocation()
        
        // 3. (location) Update the Clima > SupportingFiles > Info.plist, and add the following property:
        // Privacy - Location Usage Description & Privacy - Location When In Use Usage Description
        
        // 4.
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    // HTTP request function with Alamo
    //Write the getWeatherData method here:
    func getWeatherData(url:String,parameters:[String:String]){
        Alamofire.request(url,method: .get, parameters:parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("Success, got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!) // convert to JSON first, must use "!"
                print(weatherJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1] // Get the most accurate & updated location (last array)
        if location.horizontalAccuracy > 0 {
            // Best practice, to stop updating location when we already got the location (not 0)
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil // stop the delegate when already got location (only do this if only need  location data once)
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APP_ID]
            
            // Call http request
            getWeatherData(url:WEATHER_URL,parameters:params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


