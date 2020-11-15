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

    func configure(for weather: Weather) {
        cityNameLabel.text = weather.geoObject.city.name
        temperatureLabel.text = "\(weather.fact.temp.withSign())°"
    }
}