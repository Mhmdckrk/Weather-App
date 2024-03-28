//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the weather app").font(.largeTitle).bold().foregroundStyle(Color.white)
                Text("Please share your current location to get the weather in your area")
                    .foregroundStyle(Color.white)
                    .padding()
            }.multilineTextAlignment(.center)
                .padding()
            
            Button {
                locationManager.requestLocation()
            } label: {
                HStack {
                   Image(systemName: "location")
                Text("Get Location")
                }
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 15.0)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .background(Color(red: -0.003, green: 0.478, blue: 1.003))
            .cornerRadius(30)
            
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
