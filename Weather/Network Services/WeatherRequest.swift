//
//  WeatherRequest.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import Foundation

struct WeatherRequest {
    
    static let apiKey = "93b85a8f-b038-47d6-992d-6dc194636caa"
    
    static func fetchData(latitude: String = "",
                          longitude: String = "",
                          completionHandler: @escaping (Weather) -> Void) {
        
        let latitudeString = latitude != "" ? "lat=\(latitude)&" : ""
        let longitudeString = longitude != "" ? "lon=\(longitude)&" : ""

        let stringURL = "https://api.weather.yandex.ru/v2/forecast?\(latitudeString)\(longitudeString)lang=ru_RU&limit=7&hours=false&extra=false"
        
        let defaultHeaders = ["X-Yandex-API-Key" : apiKey]
        
        guard let url = URL(string: stringURL) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else { return }
            
//            if let string = String(data: data, encoding: .utf8) {
//                print(string)
//            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completionHandler(weather)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
