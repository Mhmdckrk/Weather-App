//
//  CityItem.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 24.03.2024.
//

import Foundation
import SwiftData

@Model
class CityItem: Identifiable {
    let id = UUID()
    let name: String?
    let state: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    
    init( name: String, state:String, country:String, lat: Double?, lon: Double?) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.state = state
        self.country = country
    }
}
