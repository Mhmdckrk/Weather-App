//
//  Extensions.swift
//  WeatherApp
//
//  Created by Mahmud CIKRIK on 28.02.2024.
//

import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
     
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
        
    }
    
}

extension LinearGradient {
    static var sunny: LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color(red: 0.85, green: 0.85, blue: 1), Color(red: 0.31, green: 0.56, blue: 1)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var circleSunny: LinearGradient {
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 196/255, green: 196/255, blue: 255/255), Color(red: 0, green: 0.36, blue: 1)]),
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        }
    
    static var circleRainy: LinearGradient {
            return LinearGradient(
                gradient: Gradient(colors: [.white, Color(red: 0, green: 0.36, blue: 1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    static var rainy: LinearGradient {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.48, green: 0.70, blue: 0.82),
                    Color(red: 0.27, green: 0.48, blue: 0.88),
                    Color(red: 0.71, green: 0.81, blue: 1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    static var night: LinearGradient {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0, green: 0.06, blue: 0.25),
                    Color(red: 0.09, green: 0.26, blue: 0.57),
                    Color(red: 0, green: 0.16, blue: 0.46)]),
                startPoint: .top,
                endPoint: .bottom)
        }
    static var nightCircle: LinearGradient {
            return LinearGradient(gradient: Gradient(colors: [
                Color(red: 0, green: 0.05, blue: 0.13),
                Color(red: 0.23, green: 0.51, blue: 1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)

        }
}

extension Color {
    
    static var nightColor: Color {
        return Color(red: 0, green: 0.06, blue: 0.18).opacity(0.30)
    }
    
}


