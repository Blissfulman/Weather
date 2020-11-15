//
//  CityWeather.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import Foundation

// MARK: - Fact
struct Fact: Decodable {
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: Condition
    let isThunder: Bool?
    let windSpeed: Double
    let windDirection: WindDirection
    let pressureMm: Int
    let humidity: Int
    let season: Season

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon
        case condition
        case isThunder = "is_thunder"
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case pressureMm = "pressure_mm"
        case humidity
        case season
    }
}

// MARK: - Condition
enum Condition: String, Decodable {
    case clear = "clear"
    case partlyCloudy = "partly-cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case drizzle = "drizzle"
    case lightRain = "light-rain"
    case rain = "rain"
    case moderateRain = "moderate-rain"
    case heavyRain = "heavy-rain"
    case continuousHeavyRain = "continuous-heavy-rain"
    case showers = "showers"
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow = "snow"
    case snowShowers = "snow-showers"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"
    
    var inRussian: String {
        switch self {
        case .clear: return "Ясно"
        case .partlyCloudy: return "Малооблачно"
        case .cloudy: return "Облачно с прояснениями"
        case .overcast: return "Пасмурно"
        case .drizzle: return "Морось"
        case .lightRain: return "Небольшой дождь"
        case .rain: return "Дождь"
        case .moderateRain: return "Умеренно сильный дождь"
        case .heavyRain: return "Сильный дождь"
        case .continuousHeavyRain: return "Длительный сильный дождь"
        case .showers: return "Ливень"
        case .wetSnow: return "Дождь со снегом"
        case .lightSnow: return "Небольшой снег"
        case .snow: return "Снег"
        case .snowShowers: return "Снегопад"
        case .hail: return "Град"
        case .thunderstorm: return "Гроза"
        case .thunderstormWithRain: return "Дождь с грозой"
        case .thunderstormWithHail: return "Гроза с градом"
        }
    }
}

// MARK: - WindDirection
enum WindDirection: String, Decodable {
    case nw
    case n
    case ne
    case e
    case se
    case s
    case sw
    case w
    case c
    
    var inRussian: String {
        switch self {
        case .nw: return "СЗ"
        case .n: return "С"
        case .ne: return "СВ"
        case .e: return "В"
        case .se: return "ЮВ"
        case .s: return "Ю"
        case .sw: return "ЮЗ"
        case .w: return "З"
        case .c: return ""
        }
    }
}

// MARK: - Season
enum Season: String, Decodable {
    case summer
    case autumn
    case winter
    case spring
}
