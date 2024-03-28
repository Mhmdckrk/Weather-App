//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherModel {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=15b2252986751b6520e35290887288e9&units=metric") else { fatalError("Missing URL") }
        print(url)
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching data")}
        
        let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
        print(decodedData)
        return decodedData
    }
    
//    func getCurrentWeather(cityModel: [CityModel]) async throws -> [WeatherModel] {
//        
//        var weathersTask = [Task<WeatherModel,Error>]()
//        var weathers = [WeatherModel]()
//        
//       
//        let name = cityModel.map{ cityModel in
//            Task {
//                do {
//                    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(cityModel.coord?.lat)&lon=\(cityModel.coord?.lon)&appid=15b2252986751b6520e35290887288e9&units=metric") else { fatalError("Missing URL") }
//                    print(url)
//                    let urlRequest = URLRequest(url: url)
//                    
//                    let (data, response) = try await URLSession.shared.data(for: urlRequest)
//                    
//                    guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching data")}
//                    
//                    let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
//                    weathers.append(decodedData)
//                }
//            }
//        }
//        
//        
//    }
    
    func searchAndgetCitiesLongLat() -> [CityModel] {
        var matchedNames = [CityModel]()

//        guard queryCityName.count >= 3 else {
//                    print("Arama sorgusu en az 3 karakter olmalıdır.")
//                    return [CityModel]()
//                }
        
        let jsonFilePath = Bundle.main.path(forResource: "citylist", ofType: "json") // JSON dosyasının adını ve uzantısını vermelisiniz
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonFilePath!))
        
        do {
            let model = try JSONDecoder().decode([CityModel].self, from: jsonData)
            
//            matchedNames = Array(model.prefix(5))
            matchedNames = model
//                .filter { $0.name!.lowercased().contains(queryCityName.lowercased()) }
//            matchedNames =  Array(matchedNames.prefix(5))
//                .map { $0.name ?? "CityName" }
            
//            if matchedNames.isEmpty {
//                            print("Bulunamadı")
//                        } else {
//                            print("Eşleşen İsimler: \(matchedNames)")
//                        }
        } catch {
            print("JSON decode hatası: \(error.localizedDescription)")
        }
        
        return matchedNames
    }
    
}
// MARK: - WeatherModel
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: Int?
    let sys: Sys
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

struct WeatherPresenter: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: Int?
    var time: String {
        guard let dt = dt else { return "" }
        guard let timezone = timezone else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(dt+timezone))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // Format sadece saat ve dakika
        return dateFormatter.string(from: date)
    }
    var timeOfDay: String {
        if let hour = Int(time.prefix(2)) {
            if hour > 18 {
                return "Evening"
            } else if hour < 5 {
                return "Evening"
            } else if hour < 11 {
                return "Morning"
            } else if hour > 11 {
                return "Noon"
            }
        }
        return "timeOfDay is nil"
    }
    let sys: Sys
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}




// MARK: - CityModelElement
struct CityModel: Codable {
    let id: Int?
    let name, state, country: String?
    let coord: Coord?
}

// MARK: - CityModelElement
struct CityPresenter: Identifiable {
    var id = UUID()
    let name, state, country: String?
    let coord: Coord?
}

//typealias CityModel = [CityModelElement]

class WeatherData: ObservableObject {
    @Published var weatherData: [WeatherPresenter] = []
    let weatherManager = WeatherManager()
    
    func appendData(lat: Double, lon: Double) async {
        Task {
            do {
                let item = try await weatherManager.getCurrentWeather(latitude: lat, longitude: lon)
                let model = WeatherPresenter(coord: item.coord, weather: item.weather, base: item.base, main: item.main, visibility: item.visibility, wind: item.wind, clouds: item.clouds, dt: item.dt, sys: item.sys, timezone: item.timezone, id: item.id, name: item.name, cod: item.cod)
                weatherData.append(model)
            }
        }
    }
    
}
