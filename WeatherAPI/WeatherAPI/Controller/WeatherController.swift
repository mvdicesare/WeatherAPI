//
//  ModelController .swift
//  WeatherAPI
//
//  Created by Michael Di Cesare on 10/2/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

//https://api.weatherbit.io/v2.0/current?postal_code=84047&key=82bde2969d0e4b79be60d6acca385535
class WeatherController {
    
   static let baseURL = URL(string: "https://api.weatherbit.io/v2.0/current")
   static let apiKey = "82bde2969d0e4b79be60d6acca385535"
  
    
    static func fetchWeather(with searchTerm: String, completion: @escaping (WeatherData?) -> Void ) {
        guard let url = baseURL else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let zipQuery = URLQueryItem(name: "postal_code", value: searchTerm)
            let apiKeyQuery = URLQueryItem(name: "key", value: apiKey)
            let unitsQuery = URLQueryItem(name: "units", value: "I")
        components?.queryItems = [zipQuery,unitsQuery, apiKeyQuery]
        guard let finalURL = components?.url else {return}
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
           if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            if let data = data {
                do {
                    let topWeatherData = try JSONDecoder().decode(TopWeatherData.self, from: data)
                    completion(topWeatherData.data.first)
                    return
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    completion(nil)
                    return
                }
            }
        }
        
        dataTask.resume()
    }
//https://www.weatherbit.io/static/img/icons/c01d.png
        
        static func getImage(weatherData: WeatherData, completion: @escaping (UIImage?) -> Void ) {
            let imageURL = URL(string: "https://www.weatherbit.io/static/img/icons/\(weatherData.weather.icon).png")!
            
            
            let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
              
                if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                guard let data = data else {return}
                guard let image = UIImage(data: data) else {return}
                completion(image)
            
        }
        dataTask.resume()
    }
} //end of class
