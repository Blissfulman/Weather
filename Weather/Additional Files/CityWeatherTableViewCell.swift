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
        cityNameLabel.text = weather.geoObject.city.name
        temperatureLabel.text = "\(weather.fact.temp.withSign())°"
        
        networkManager.fetchConditionImage(weather.fact.icon,
                                           toSize: iconConditionView.bounds) {
            [weak self] image in
            
            guard let `self` = self else { return }

            self.iconConditionView.addSubview(image)
        }
    }
}
