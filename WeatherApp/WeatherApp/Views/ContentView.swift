//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    // StateObject Published'leri notify olmasını sağlar.
    
    var weatherManager = WeatherManager()
    @State var weather: WeatherPresenter?
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = weather {
                    WeaView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                               let item = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                weather = WeatherPresenter(coord: item.coord, weather: item.weather, base: item.base, main: item.main, visibility: item.visibility, wind: item.wind, clouds: item.clouds, dt: item.dt, sys: item.sys, timezone: item.timezone, id: item.id, name: item.name, cod: item.cod)
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView().environmentObject(locationManager)
                    // REMEMBER: Eğer Gidilecek Sayfada/View'da Environment object olmazsa burada crash olur onun için ilk @Environment object ekle.
                }
            }
            
        }.background(Color(red: 0.073, green: 0.087, blue: 0.307)).preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
