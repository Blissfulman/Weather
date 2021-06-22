//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Evgeny Novgorodov on 15.11.2020.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var weekdayLabel: UILabel!
    @IBOutlet private var dayTemperatureLabel: UILabel!
    @IBOutlet private var nightTemperatureLabel: UILabel!
    @IBOutlet private var iconConditionView: UIView!

    // MARK: - Properties
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods
    
    func configure(for forecast: Forecast) {
        if let date = getDateFromString(forecast.date) {
            dateLabel.text = getStringFromDate(date)
            weekdayLabel.text = getWeekdayDate(date)
            weekdayLabel.textColor = isWeekend(date) ? .orange : .black
        }
        
        dayTemperatureLabel.text = "\(forecast.parts?.dayShort?.temp?.withSign() ?? "")°"
        nightTemperatureLabel.text = "\(forecast.parts?.nightShort?.temp?.withSign() ?? "")°"
        
        networkManager.fetchConditionImage(
            forecast.parts?.dayShort?.icon ?? "",
            toSize: iconConditionView.bounds
        ) { [weak self] image in
            self?.iconConditionView.addSubview(image)
        }
    }
    
    // MARK: - Private methods
    
    private func getDateFromString(_ stringDate: String?) -> Date? {
        guard let stringDate = stringDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Error date format")
            return nil
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
    
    private func isWeekend(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "e"
        return dateFormatter.string(from: date) == "6" || dateFormatter.string(from: date) == "7"
    }
}
