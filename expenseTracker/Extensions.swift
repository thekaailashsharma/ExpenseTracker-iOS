//
//  Extensions.swift
//  fold
//
//  Created by Admin on 12/11/23.
//

import Foundation
import SwiftUI


extension Color {
    static let background = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumeric: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let date = DateFormatter.allNumeric.date(from: self) else {return Date()}
    
        return date
        
    }
}
