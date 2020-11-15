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
}

// MARK: - Parts
struct Parts: Decodable {
    let nightShort, dayShort: ShortInfo

    enum CodingKeys: String, CodingKey {
        case nightShort = "night_short"
        case dayShort = "day_short"
    }
}

// MARK: - ShortInfo
struct ShortInfo: Decodable {
    let temp: Int
    let icon: String
    let condition: Condition
}
