//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 29.02.2024.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888, opacity: 0.258))
                .cornerRadius(50)
                .foregroundColor(Color.white)

            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.caption)
                    .foregroundColor(Color.white)
                
                Text(value)
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.title)
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
    }
}
