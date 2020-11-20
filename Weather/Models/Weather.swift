//
//  Weather.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let info: Info?
    let geoObject: GeoObject?
    let fact: Fact?
    let forecasts: [Forecast]?

    enum CodingKeys: String, CodingKey {
        case info
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
        
    init?(from jsonData: Any) {
        guard let jsonData = jsonData as? [String : Any] else { return nil }
        
        info = Info(from: jsonData["info"] as? [String : Any] ?? [:])
        geoObject = GeoObject(from: jsonData["geo_object"] as? [String : Any] ?? [:])
        fact = Fact(from: jsonData["fact"] as? [String : Any] ?? [:])
        
        let forecastsData = jsonData["forecasts"] as? [[String: Any]] ?? []
        forecasts = forecastsData.compactMap { Forecast(from: $0) }
    }
}

// MARK: - Info
struct Info: Decodable {
    let n: Bool?
    let geoid: Int?
    let url: String?
    let lat, lon: Double?
    
    init(from jsonData: [String : Any]) {
        n = jsonData["n"] as? Bool
        geoid = jsonData["geoid"] as? Int
        url = jsonData["url"] as? String
        lat = jsonData["lat"] as? Double
        lon = jsonData["lon"] as? Double
    }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case city = "locality"
    }
    
    init(from jsonData: [String : Any]) {
        city = City(from: jsonData["locality"] as? [String : Any] ?? [:])
    }
}

// MARK: - City
struct City: Decodable {
    let name: String?
    
    init(from jsonData: [String : Any]) {
        name = jsonData["name"] as? String
    }
}
