//
//  CityWeatherTableViewCell.swift
//  Weather
//
//  Created by Evgeny Novgorodov on 15.11.2020.
//

import UIKit

final class CityWeatherTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var iconConditionView: UIView!
    
    // MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods
    
    func configure(for weather: Weather) {
        guard let cityName = weather.geoObject?.city?.name,
              let temp = weather.fact?.temp?.withSign() else { return }
        
        cityNameLabel.text = cityName
        temperatureLabel.text = "\(temp)°"
        
        networkManager.fetchConditionImage(
            weather.fact?.icon ?? "",
            toSize: iconConditionView.bounds
        ) { [weak self] image in
            self?.iconConditionView.addSubview(image)
        }
    }
}
