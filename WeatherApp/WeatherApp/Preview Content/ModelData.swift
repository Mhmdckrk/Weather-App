//
//  ModelData.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import Foundation

var previewWeather: WeatherPresenter = load("weatherData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        let item = try decoder.decode(T.self, from: data) as! WeatherModel
        return WeatherPresenter(coord: item.coord, weather: item.weather, base: item.base, main: item.main, visibility: item.visibility, wind: item.wind, clouds: item.clouds, dt: item.dt, sys: item.sys, timezone: item.timezone, id: item.id, name: item.name, cod: item.cod) as! T
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
