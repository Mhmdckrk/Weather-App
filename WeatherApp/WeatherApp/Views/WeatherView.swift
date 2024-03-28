////
////  WeatherView.swift
////  WeatherApp
////
////  Created by Mahmud CIKRIK on 28.02.2024.
////
//
//import SwiftUI
//
//struct WeatherView: View {
//    var weather: WeatherModel
//    
//    var body: some View {
//        ZStack(alignment: .leading) {
//            VStack {
//                VStack(alignment:.leading,spacing: 5){
//                    Text(weather.name ?? "City")
//                        .bold().font(.title)
//                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
//                        .fontWeight(.light)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                Spacer()
//                VStack {
//                    HStack {
//                        VStack(spacing: 20) {
//                            Image(systemName: "sun.max")
//                                .font(.system(size: 40))
//                            Text(weather.weather[0].main ?? "Air")
//                            
//                        }.frame(width: 150, alignment: .leading)
//                        Spacer()
//                        Text("\(weather.main?.feelsLike?.roundDouble() ?? "")" + "°")
//                            .font(.system(size: 100))
//                            .fontWeight(.bold)
//                            .padding()
//                    }
//                    
//                    Spacer()
//                        .frame(height: 80)
//                    
//                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 350)
//
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity)
//            }
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            
//            VStack {
//                Spacer()
//                
//                VStack(alignment: .leading, spacing: 20) {
//                    Text("Weather Now")
//                        .bold().padding(.bottom)
//                    
//                    HStack {
//                        WeatherRow(logo: "thermometer", name: "Min temp", value: "\(weather.main?.tempMin?.roundDouble() ?? "")°")
//                        Spacer()
//                        WeatherRow(logo: "thermometer", name: "Max temp", value: "\(weather.main?.tempMax?.roundDouble() ?? "")°")
//                    }
//                    HStack {
//                        WeatherRow(logo: "wind", name: "Wind speed", value: "\(weather.wind.speed?.roundDouble() ?? "")m/s")
//                        Spacer()
//                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main?.humidity ?? 0)%")
//                    }
//                    
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding()
//                .padding(.bottom, 20)
//                .foregroundColor(Color(red: 0.073, green: 0.087, blue: 0.307)).preferredColorScheme(.dark)
//                .background(.white)
//                .cornerRadius(20, corners: [.topLeft, .topRight])
//            }
//            
//            
//        }
//        .edgesIgnoringSafeArea(.bottom)
//        .background(Color(red: 0.073, green: 0.087, blue: 0.307)).preferredColorScheme(.dark)
//    }
//}
//
//#Preview {
//    WeatherView(weather: previewWeather)
//}
