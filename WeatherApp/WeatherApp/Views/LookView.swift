//
//  LookView.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 21.03.2024.
//

import SwiftUI
import SwiftData

struct LookView: View {
    
    @Environment(\.modelContext) var context
    
    var weatherManager = WeatherManager()
    
    @State private var cities: [CityModel] = []
    @State private var weathers: [WeatherModel] = []
        
    @Query var items: [CityItem]
    
    @State private var searchTerm = ""
    var filteredCities: [CityPresenter] {
        if searchTerm.count >= 3 {
            var newCities = cities.filter {  $0.name?.localizedCaseInsensitiveContains(searchTerm) ?? true }.map { CityPresenter(name: $0.name, state: $0.state, country: $0.country, coord: $0.coord)}
            newCities = Array(newCities.prefix(10))
            return newCities
        } 
        else {
            if !items.isEmpty {
                let newCities = items.map { CityPresenter ( name: $0.name, state: $0.state, country: $0.country, coord: nil) }
                return newCities
            }
        }
        return []
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCities, id: \.id) { item in
                    HStack {
                        Text("\(item.name ?? "City"),")
                        Text(item.state ?? "State")
                        Text(item.country ?? ",Country")
                        Spacer()
                        Button(action: {
                            let newItem = CityItem(name: item.name ?? "City", state: item.state ?? "State", country: item.country ?? "Country", lat: item.coord?.lat, lon: item.coord?.lon)
                            context.insert(newItem)
                            
                            searchTerm = ""
                            
                        }, label: {
                            Image(systemName: "plus").frame(width: 30, height: 30).background(Color(hue: 1.0, saturation: 0.0, brightness: 0.866))
                                .cornerRadius(8.0)
                                .foregroundColor(.black)
                        })
                    }
                }.onDelete { indexSet in
                    indexSet.forEach { index in
                        context.delete(items[index])
                    }
                }
                
            }
            .overlay {
                if items.isEmpty && filteredCities.isEmpty {
                    Text("No Saved Items")
                }
            }
            .navigationTitle("Saved Locations")
            .searchable(text: $searchTerm , prompt: "Search Cities") {
                
            }
            .task {
                cities = weatherManager.searchAndgetCitiesLongLat()
            }
        }
    }
}

#Preview {
    LookView()
}

//                weathers = filteredCities.map { weatherManager.getCurrentWeather(latitude: ($0.coord?.lat)!, longitude: ($0.coord?.lon)!)
//                        }
