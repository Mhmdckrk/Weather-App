//
//  SearchListView.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 21.03.2024.
//

import SwiftUI

struct SearchListView: View {
    
    var weatherManager = WeatherManager()

    @State private var model: [WeatherModel] = []
    @State private var cityModel: [CityModel] = []
    
    var body: some View {
        List(model, id: \.id) { singleItem in
            HStack {
                Image(systemName: "sun.max")
                .font(.system(size: 40))
                Text(singleItem.weather[0].main ?? "Air")
            }
        }
        .task {
//            model = await weatherManager.getCurrentWeather(latitude: si.latitude, longitude: location.longitude)
        }

    }
}

#Preview {
    SearchListView()
}
