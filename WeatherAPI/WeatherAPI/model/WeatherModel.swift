//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Michael Di Cesare on 10/2/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation

struct TopWeatherData: Codable {
    let data: [WeatherData]
}

struct WeatherData: Codable {
    let weather: Weather
    let stateCode: String
    let cityName: String
    let tempature: Double
    let sunsetTime: String
    let sunriseTime: String
    let barametricPressure: Double
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case stateCode = "state_code"
        case cityName = "city_name"
        case tempature = "temp"
        case sunsetTime = "sunset"
        case sunriseTime = "sunrise"
        case barametricPressure = "pres"
    }
    
    struct Weather: Codable {
        let outsideDescription: String
        let icon: String
        
        private enum CodingKeys: String, CodingKey {
            case outsideDescription = "description"
            case icon = "icon"
        }
    }
}
