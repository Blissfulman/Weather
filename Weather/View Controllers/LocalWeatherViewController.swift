//
//  LocalWeatherViewController.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import UIKit

class LocalWeatherViewController: UIViewController {

    // MARK: - Outlets    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var feelsLikeLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var airPressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    @IBOutlet var iconConditionView: UIView!
    
    @IBOutlet var forecastTableView: UITableView!
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    
    private var weather: Weather!
    private var forecasts = [Forecast]()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setupViewGradient(
            withColors: [UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor],
            opacity: 0.2
        )

        networkManager.fetchWeatherData { [weak self] weather in
            
            guard let `self` = self else { return }

            DispatchQueue.main.async {
                self.weather = weather
                self.updateLocalWeather()
                self.forecasts = weather.forecasts
                self.forecastTableView.reloadData()
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let webVC = segue.destination as! WebViewController
        webVC.url = weather.info.url
        webVC.title = weather.geoObject.city.name
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK: - Private methods
    private func updateLocalWeather() {
        
        let fact = weather.fact
        
        title = weather.geoObject.city.name
        temperatureLabel.text = "\(fact.temp.withSign())°"
        conditionLabel.text = fact.condition.inRussian
        feelsLikeLabel.text = "Ощущается как: \(fact.feelsLike.withSign())°"
        windLabel.text = fact.windDirection == .c
            ? "\(fact.windSpeed) м/с"
            : "\(fact.windSpeed) м/с, \(fact.windDirection.inRussian)"
        airPressureLabel.text = "\(fact.pressureMm) мм рт. ст."
        humidityLabel.text = "\(fact.humidity)%"

        networkManager.fetchConditionImage(fact.icon,
                                           toSize: iconConditionView.bounds) {
            [weak self] image in
            
            guard let `self` = self else { return }

            self.iconConditionView.addSubview(image)
        }
    }
}

// MARK: - TableViewDataSource
extension LocalWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell") as! ForecastTableViewCell
        cell.configure(for: forecasts[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension LocalWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
