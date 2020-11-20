//
//  CityWeatherTableViewCell.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {

    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var iconConditionView: UIView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(for weather: Weather) {
        
        guard let cityName = weather.geoObject?.city?.name else { return }
        guard let temp = weather.fact?.temp?.withSign() else { return }
        
        cityNameLabel.text = cityName
        temperatureLabel.text = "\(temp)°"
        
        networkManager.fetchConditionImage(weather.fact?.icon ?? "",
                                           toSize: iconConditionView.bounds) {
            [weak self] image in
            
            guard let `self` = self else { return }

            self.iconConditionView.addSubview(image)
        }
    }
}
