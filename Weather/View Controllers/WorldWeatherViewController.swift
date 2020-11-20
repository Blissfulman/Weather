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
    private let networkManager = NetworkManager.shared
    
    private var weatherInCities = [Weather]()
    private let cityNames = ["Санкт-Петербург", "Сочи", "Владивосток", "Париж",
                             "Лондон", "Милан", "Лиссабон", "Торонто", "Якутск"]
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setupViewGradient(
            withColors: [UIColor.systemTeal.cgColor, UIColor.systemGreen.cgColor],
            opacity: 0.2
        )
        
        cityNames.forEach { addCity($0) }
    }
    
    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        addCityAlert { [weak self] sityName in
            guard let `self` = self else { return }
            self.addCity(sityName)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let webVC = segue.destination as! WebViewController
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let weather = weatherInCities[selectedIndexPath.item]
        webVC.url = weather.info?.url
        webVC.title = weather.geoObject?.city?.name
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }

    // MARK: - Private methods
    private func addCity(_ cityName: String) {
        
        getCityCoordinates(for: cityName) {
            [weak self] (coordinates, error) in
            
            guard let `self` = self else { return }
            
            guard let coordinates = coordinates else { return }
            
            self.networkManager.fetchWeatherDataAF(
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
    
    private func addCityAlert(completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(
            title: "Добавление города",
            message: "Введите название города, который необходимо добавить",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in
            let alertTextField = alertController.textFields?.first
            guard let text = alertTextField?.text else { return }
            completionHandler(text)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Город"
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
}

// MARK: - TableViewDelegate
extension WorldWeatherViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWebView", sender: nil)
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

// MARK: - Finding location
extension WorldWeatherViewController {
    
    private func getCityCoordinates(
        for city: String,
        completionHandler: @escaping (_ coordinates: CLLocationCoordinate2D?,
                                      _ error: Error?) -> Void
    ) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completionHandler(placemark?.first?.location?.coordinate, error)
        }
    }
}
