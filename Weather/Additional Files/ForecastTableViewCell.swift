//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weekdayLabel: UILabel!
    @IBOutlet var dayTemperatureLabel: UILabel!
    @IBOutlet var nightTemperatureLabel: UILabel!

    // MARK: - Setup UI
    func configure(for forecast: Forecast) {
        let date = getDateFromString(forecast.date)
        dateLabel.text = getStringFromDate(date)
        weekdayLabel.text = getWeekdayDate(date)
        dayTemperatureLabel.text = "\(forecast.parts.dayShort.temp)°"
        nightTemperatureLabel.text = "\(forecast.parts.nightShort.temp)°"
    }
    
    // MARK: - Private methods
    private func getDateFromString(_ stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Error date format")
            return Date()
        }
        return date
    }
    
    private func getStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
    
    private func getWeekdayDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
}
