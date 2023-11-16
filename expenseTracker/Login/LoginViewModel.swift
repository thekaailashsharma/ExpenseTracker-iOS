//
//  LoginViewModel.swift
//  ExpenseTracker
//
//  Created by Admin on 16/11/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var phoneNumber = ""
    
    func getCountryCode() -> String {
        let regionCode = Locale.current.regionCode ?? "+91"
        return countryCodeList[regionCode] ?? ""
    }
    
    func countryFlag(_ countryCode: String) -> String {
      String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
      }))
    }
}
