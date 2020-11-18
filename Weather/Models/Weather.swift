//
//  Weather.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let info: Info
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case info
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
        
    init(jsonData: [String : Any]) {
        info = Info.getInfo(from: jsonData["info"] as! [String : Any])
        geoObject = GeoObject.getGeoObject(from: jsonData["geo_object"] as! [String : Any])
        fact = Fact.getFact(from: jsonData["fact"] as! [String : Any])
        forecasts = Forecast.getForecast(from: jsonData["forecasts"] as! [[String : Any]])
    }
    
    static func getWeather(from value: Any) -> Weather? {
        guard let data = value as? [String: Any] else { return nil }
        return Weather(jsonData: data)
    }
}

// MARK: - Info
struct Info: Decodable {
    let n: Bool
    let geoid: Int
    let url: String
    let lat, lon: Double
    
    init(jsonData: [String : Any]) {
        n = jsonData["n"] as! Bool
        geoid = jsonData["geoid"] as! Int
        url = jsonData["url"] as! String
        lat = jsonData["lat"] as! Double
        lon = jsonData["lon"] as! Double
    }
    
    static func getInfo(from value: Any) -> Info {
        let data = value as! [String: Any]
        return Info(jsonData: data)
    }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case city = "locality"
    }
    
    init(jsonData: [String : Any]) {
        city = City.getCity(from: jsonData["locality"] as! [String : Any])
    }
    
    static func getGeoObject(from value: Any) -> GeoObject {
        let data = value as! [String: Any]
        return GeoObject(jsonData: data)
    }
}

// MARK: - City
struct City: Decodable {
    let name: String
    
    init(jsonData: [String : Any]) {
        name = jsonData["name"] as! String
    }
    
    static func getCity(from value: Any) -> City {
        let data = value as! [String: Any]
        return City(jsonData: data)
    }
}
