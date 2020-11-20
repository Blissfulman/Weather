//
//  Forecast.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

// MARK: - Forecast
struct Forecast: Decodable {
    let date: String?
    let parts: Parts?
    
    init(from jsonData: [String : Any]) {
        date = jsonData["date"] as? String
        parts = Parts(from: jsonData["parts"] as? [String : Any] ?? [:])
    }
}

// MARK: - Parts
struct Parts: Decodable {
    let nightShort, dayShort: ShortInfo?

    enum CodingKeys: String, CodingKey {
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
    
    init(from jsonData: [String : Any]) {
        nightShort = ShortInfo(from: jsonData["night_short"] as? [String : Any] ?? [:])
        dayShort = ShortInfo(from: jsonData["day_short"] as? [String : Any] ?? [:])
    }
}

// MARK: - ShortInfo
struct ShortInfo: Decodable {
    let temp: Int?
    let icon: String?
    let condition: Condition?
    
    init(from jsonData: [String : Any]) {
        temp = jsonData["temp"] as? Int
        icon = jsonData["icon"] as? String
        condition = Condition(from: jsonData["condition"] as! String)
    }
}
