//
//  Forecast.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

// MARK: - Forecast
struct Forecast: Decodable {
    let date: String
    let parts: Parts
    
    init(jsonData: [String : Any]) {
        date = jsonData["date"] as! String
        parts = Parts.getParts(from: jsonData["parts"] as! [String : Any])
    }
    
    static func getForecast(from value: Any) -> [Forecast] {
        let data = value as! [[String: Any]]
        return data.compactMap { Forecast(jsonData: $0) }
    }
}

// MARK: - Parts
struct Parts: Decodable {
    let nightShort, dayShort: ShortInfo

    enum CodingKeys: String, CodingKey {
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
    
    init(jsonData: [String : Any]) {
        nightShort = ShortInfo.getShortInfo(from: jsonData["night_short"] as! [String : Any])
        dayShort = ShortInfo.getShortInfo(from: jsonData["day_short"] as! [String : Any])
    }
    
    static func getParts(from value: Any) -> Parts {
        let data = value as! [String: Any]
        return Parts(jsonData: data)
    }
}

// MARK: - ShortInfo
struct ShortInfo: Decodable {
    let temp: Int
    let icon: String
    let condition: Condition?
    
    init(jsonData: [String : Any]) {
        temp = jsonData["temp"] as! Int
        icon = jsonData["icon"] as! String
        condition = Condition.getCondition(from: jsonData["condition"] as! String)
    }
    
    static func getShortInfo(from value: Any) -> ShortInfo {
        let data = value as! [String: Any]
        return ShortInfo(jsonData: data)
    }
}
