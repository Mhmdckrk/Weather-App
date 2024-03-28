//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import SwiftUI
import SwiftData


struct WeaView: View {
    
    @StateObject private var weatherClass = WeatherData()
    
    var weather: WeatherPresenter
    var currentIndex: Int = 0
    var weatherManager = WeatherManager()
//    @State private var weatherData: [WeatherModel] = []
    @State private var backgroundColor: LinearGradient = LinearGradient.sunny
    @State private var opacityStars: Double = 0
    @State private var circleColor: LinearGradient = LinearGradient.sunny
    
    
    @State private var selectedCityIndex = 0
    @State private var timer = Timer.publish(every: 600, on: .main, in: .common).autoconnect()
    
    @Query var items: [CityItem]

    var body: some View {
        
        NavigationView {
            
            NavigationStack {
                
                ZStack(alignment: .center) {
                    Image("stars")
                        .opacity(opacityStars)
                        .offset(CGSize(width: 10.0, height: -330.0))
                        .blendMode(.screen)
                        .frame(width: 450)
                    Ellipse()
                        .offset(CGSize(width: 10.0, height: 200.0))
                        .fill(circleColor)
                        .frame(width: 730, height: 730)
                        .opacity(0.4)
                        .background(.clear)
                
                
                    TabView (selection: $selectedCityIndex) {
                    ForEach(weatherClass.weatherData.indices, id: \.self) { index in
                        ExtractedView(weather: weatherClass.weatherData[index])            .animation(.easeIn(duration: 0.8))
                            .tag(index)
                            
                    }
                    }.onChange(of: selectedCityIndex) { index in
                if weatherClass.weatherData[index].weather[0].main == "Rain" {
                    self.backgroundColor = LinearGradient.rainy
                    self.circleColor = LinearGradient.circleRainy
                    self.opacityStars = 0.0
                } else if weatherClass.weatherData[index].timeOfDay == "Evening" {
                    self.backgroundColor = LinearGradient.night
                    self.circleColor = LinearGradient.nightCircle
                    self.opacityStars = 1.0
                } else {
                    self.backgroundColor = LinearGradient.sunny
                    self.circleColor = LinearGradient.circleSunny
                    self.opacityStars = 0.0
                }
            }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                
                
                }.onAppear {
                                weatherClass.weatherData.append(weather)
                                Task {
                                    do {
                                        if !items.isEmpty {
                                            print("hello")
                                            for item in items {
                                                await weatherClass.appendData(lat: item.lat ?? 0.0, lon: item.lon ?? 0.0)
                                            }
                                        }
                                    }
                                }
                            }
                            .onDisappear {
                                print("hello")
                                weatherClass.weatherData.removeAll()
                            }
                
                .edgesIgnoringSafeArea(.bottom)
                .background(backgroundColor)
                .preferredColorScheme(.light)
                
            }
                
           
            
        }
    }
}

#Preview {
    WeaView(weather: previewWeather)
}

struct ExtractView: View {
    var weather: WeatherPresenter

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .bottom) {
                Text("27 Mar, \(weather.timeOfDay)")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .bold().padding(.top, 10.0)
                Spacer()
                HStack {
                    Text("More")
                        .font(.body)
                        .foregroundColor(Color.white)
                    .padding(.trailing, 0.0)
                    Image(systemName: "arrow.up.right")
                        .imageScale(.small)
                        .foregroundColor(Color.white)
                }
            }.padding(.horizontal, 5)
            Spacer()
            HStack {
                WeatherRow(logo: "thermometer", name: "Min temp", value: "\(weather.main?.tempMin?.roundDouble() ?? "")°")
                Spacer()
                WeatherRow(logo: "thermometer", name: "Max temp", value: "\(weather.main?.tempMax?.roundDouble() ?? "")°")
            }
            HStack {
                WeatherRow(logo: "wind", name: "Wind speed", value: "\(weather.wind.speed?.roundDouble() ?? "")m/s")
                Spacer()
                WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main?.humidity ?? 0)%")
            }
            
        }
        .frame(maxWidth: 400,maxHeight: 200, alignment: .center)
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(Color(red: 0.073, green: 0.087, blue: 0.307)).preferredColorScheme(.dark)
        .background {
            if weather.timeOfDay == "Evening" && weather.weather[0].main != "Rain" {
                Color.nightColor
            } else {
                Color(red: 0.0, green: 0.2666, blue: 0.788, opacity: 0.3)
            }
        }
        .cornerRadius(30, corners: .allCorners)
    }
}

struct ExtractedView: View {
    
    var weather: WeatherPresenter
    
    @State private var opacity: Double = 1
    
    var body: some View {
        
        
        VStack {
            HStack {
                
                Image(systemName: "location").imageScale(.large)
                    .foregroundStyle(Color.white)
                Text(weather.name ?? "City").foregroundColor(Color.white)
                    .bold().font(.title)
                Spacer()
                Menu {
                    NavigationLink {
                        LookView()
                    } label: {
                        Text("Add Location")
                    }
                    NavigationLink {
                        //                            Text("\(items.count)")
                    } label: {
                        Text("Settings")
                    }
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
                
                .frame(width: 30, height: 30)
                
                
                
            }
            .frame(maxWidth: 370, maxHeight: .infinity, alignment: .leading)
            Spacer()
            
            VStack(alignment: .center, spacing: 0) { 
                Spacer().frame(height: 40)
                if weather.weather[0].main == "Rain" {
                    Image("rainy").resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else if weather.timeOfDay == "Evening"  {
                    Image("moon").resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Image("partly_cloudy").resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                Text("\(weather.main?.feelsLike?.roundDouble() ?? "")" + "°")
                    .font(.system(size: 90))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.leading, 25.0)
                
                Text(weather.weather[0].main ?? "Air")
                    .font(.title)
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: 370)
            Spacer()
            VStack {
                Spacer().frame(height: 30)
                ExtractView(weather: weather)
            }.padding(.bottom, 10.0)
        }
        .padding()
        .frame(maxWidth: 370, maxHeight: .infinity)
        .opacity(opacity)
//        .onAppear {
//            withAnimation {
//                // Animasyonlu şekilde görünür hale getiriyoruz
//                self.opacity = 1
//                
//            }
//        }
//        .onDisappear {
//            withAnimation {
//                // Animasyonlu şekilde görünür hale getiriyoruz
//                self.opacity = 0
//                
//            }
//        }
    }
}
