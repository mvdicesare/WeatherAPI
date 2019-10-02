//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Michael Di Cesare on 10/2/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var zipCodeText: UITextField!
    @IBOutlet weak var weatherDisplay: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designWeatherDisplay()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        guard let zipCodeString = zipCodeText.text, !zipCodeString.isEmpty else { return }
        
        WeatherController.fetchWeather(with: zipCodeString) { (weatherData) in
            guard let weatherData = weatherData else { return }
            
            DispatchQueue.main.async {
                self.weatherDisplay.text = """
                \(weatherData.cityName),  \(weatherData.stateCode)
                \(weatherData.tempature) Fº
                \(weatherData.barametricPressure) in mg
                \(weatherData.sunriseTime) Sun Rise
                \(weatherData.sunsetTime) Sun Set
                \(weatherData.weather.outsideDescription)
                """
                WeatherController.getImage(weatherData: weatherData) { (image) in
                    DispatchQueue.main.async {
                        self.iconImageView.image = image
                    }
                }
                //self.presentIcon(weatherData: weatherData)
            }
        }
    }
    func designWeatherDisplay () {
        weatherDisplay.layer.borderWidth = 2
        weatherDisplay.layer.borderColor = UIColor.gray.cgColor
    }
    
//    func presentIcon(weatherData: WeatherData) {
//
//        switch weatherData.weather.icon {
//        case "c01d":
//            iconImageView.image = #imageLiteral(resourceName: "c01d")
//        case ""
//        default:
//            break
//        }
//    }
} // end of class
