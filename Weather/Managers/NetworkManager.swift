//
//  WeatherRequest.swift
//  Weather
//
//  Created by Evgeny Novgorodov on 14.11.2020.
//

import UIKit
import Alamofire
import SwiftSVG

struct NetworkManager {
    
    // MARK: - Static properties
    
    static let shared = NetworkManager()
    
    // MARK: - Properties
    
    private let apiKey = ""
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Pubilc methods
    
    func fetchWeatherData(
        latitude: String = "",
        longitude: String = "",
        completionHandler: @escaping (Weather) -> Void
    ) {
        let latitudeString = latitude != "" ? "lat=\(latitude)&" : ""
        let longitudeString = longitude != "" ? "lon=\(longitude)&" : ""

        let stringURL = "https://api.weather.yandex.ru/v2/forecast?\(latitudeString)\(longitudeString)lang=ru_RU&limit=7&hours=false&extra=false"
                
        guard let url = URL(string: stringURL) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-Yandex-API-Key" : apiKey]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completionHandler(weather)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchWeatherDataAF(
        latitude: String = "",
        longitude: String = "",
        completionHandler: @escaping (Weather) -> Void
    ) {
        let latitudeString = latitude != "" ? "lat=\(latitude)&" : ""
        let longitudeString = longitude != "" ? "lon=\(longitude)&" : ""

        let stringURL = "https://api.weather.yandex.ru/v2/forecast?\(latitudeString)\(longitudeString)lang=ru_RU&limit=7&hours=false&extra=false"
        
        let header: HTTPHeaders = ["X-Yandex-API-Key" : apiKey]
        
        AF.request(stringURL, headers: header)
            .responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    completionHandler(weather)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        
        // Вариант с ручным парсингом данных
//            .responseJSON() { response in
//                switch response.result {
//                case let .success(jsonData):
//                    guard let weather = Weather(from: jsonData) else { return }
//                    completionHandler(weather)
//                case .failure(let error):
//                    print(error)
//                }
//            }
    }
    
    func fetchConditionImage(
        _ icon: String,
        toSize size: CGRect,
        completionHandler: @escaping (UIView) -> Void
    ) {
        let stringImageURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg"
        guard let imageURL = URL(string: stringImageURL) else { return }
        let conditionImage = UIView(SVGURL: imageURL) { image in
            image.resizeToFit(
                CGRect(
                    x: size.origin.x,
                    y: size.origin.y,
                    width: size.width * 0.85,
                    height: size.height * 0.85
                )
            )
        }
        completionHandler(conditionImage)
    }
}
