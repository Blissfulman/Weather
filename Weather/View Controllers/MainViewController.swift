//
//  MainViewController.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import UIKit
import WebKit

class MainViewController: UIViewController {

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var airPressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var iconWeatherImage: UIImageView!
    @IBOutlet var iconWebView: WKWebView!
    
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherRequest.fetchData { weather in
            
            DispatchQueue.main.async {
                print(weather)
                self.weather = weather
                self.updateWeatherData()
            }
        }
    }

    private func updateWeatherData() {
        
        let fact = weather.fact
        
        title = weather.geoObject.city.name
        cityLabel.text = weather.geoObject.city.name
        temperatureLabel.text = "\(fact.temp)°"
        conditionLabel.text = fact.condition.inRussian
        feelsLikeLabel.text = "Ощущается как: \(fact.feelsLike)°"
        windLabel.text = fact.windDirection == .c
            ? "\(fact.windSpeed) м/с"
            : "\(fact.windSpeed) м/с, \(fact.windDirection.inRussian)"
        airPressureLabel.text = "\(fact.pressureMm) мм рт. ст."
        humidityLabel.text = "\(fact.humidity)%"
        print(Thread.current)
        
        
//        let stringURL = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(fact.icon).svg"
//        DispatchQueue.global().async {
//            guard let imageURL = URL(string: stringURL) else { return }
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            DispatchQueue.main.async {
//                let urlRequest = URLRequest(url: imageURL)
//                self.iconWebView.load(urlRequest)
//                self.iconWeatherImage.image = UIImage(data: imageData)
//            }
//        }
    }
}
