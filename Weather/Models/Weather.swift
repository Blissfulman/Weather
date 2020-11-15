//
//  Weather.swift
//  Weather
//
//  Created by User on 14.11.2020.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
//    let now: Int
//    let nowDt: String
    let info: Info
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
//        case now
//        case nowDt = "now_dt"
        case info
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
}

// MARK: - Info
struct Info: Decodable {
    let n: Bool
    let geoid: Int
    let url: String
    let lat, lon: Double
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case city = "locality"
    }
}

// MARK: - City
struct City: Decodable {
    let name: String
}
