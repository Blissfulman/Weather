//
//  WorldWeatherViewController.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import UIKit
import CoreLocation

class WorldWeatherViewController: UITableViewController {
    
    // MARK: - Properties
    var weatherInCities = [Weather]()
    let cityNames = ["Санкт-Петербург", "Сочи", "Владивосток", "Париж",
                     "Лондон", "Милан", "Барселона", "Торонто"]
    
    // MARK: - Lifecucle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setupViewGradient(
            withColors: [UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor],
            opacity: 0.2
        )
        
        for cityName in cityNames {
            getCityCoordinates(for: cityName) {
                [weak self] (coordinates, error) in
                
                guard let `self` = self else { return }

                guard let coordinates = coordinates else { return }
                
                WeatherRequest.fetchData(
                    latitude: String(coordinates.latitude),
                    longitude: String(coordinates.longitude)) {
                    (weather) in
                    
                    self.weatherInCities.append(weather)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! WebViewController
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let weather = weatherInCities[selectedIndexPath.item]
        webVC.url = weather.info.url
        webVC.title = weather.geoObject.city.name
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }

    // MARK: - Private methods
    private func getCityCoordinates(
        for city: String, completionHandler: @escaping (_ coordinates: CLLocationCoordinate2D?, _ error: Error?) -> Void
    ) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completionHandler(placemark?.first?.location?.coordinate, error)
        }
    }
}

// MARK: - TableViewDataSource
extension WorldWeatherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherInCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityWeatherCell") as! CityWeatherTableViewCell
        cell.configure(for: weatherInCities[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {
            [weak self] (_, _, completionHandler) in
            
            guard let `self` = self else { return }
            
            self.weatherInCities.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - TableViewDelegate
extension WorldWeatherViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWebView", sender: nil)
    }
}
