//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CityItem.self)
    }
}
