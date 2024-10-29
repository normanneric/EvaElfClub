//
//  Extension.swift
//  EvaClub
//
//  Created by D K on 21.10.2024.
//

import SwiftUI

extension Color {
    static let darkGray = Color(#colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1))
    
    static let buttonGrayLight = Color(#colorLiteral(red: 0.2470588235, green: 0.2431372549, blue: 0.2431372549, alpha: 1))
    static let buttonGrayDark = Color(#colorLiteral(red: 0.1803921569, green: 0.168627451, blue: 0.168627451, alpha: 1))
    
    static let buttonOrangeLight = Color(#colorLiteral(red: 0.9294117647, green: 0.5137254902, blue: 0.2549019608, alpha: 1))
    static let buttonOrangeDark = Color(#colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.1921568627, alpha: 1))
    
}

extension View {
    func size() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
