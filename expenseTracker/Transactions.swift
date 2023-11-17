//
//  Transactions.swift
//  fold
//
//  Created by Admin on 12/11/23.
//

import Foundation
import SwiftUIFontIcon

struct Transaction : Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let categoryId: Int
    let category: String
    let isPending: Bool
    var isTransfer: Bool = false
    var isExpense: Bool = false
    var isEdited: Bool = false
    let type: TransactionType.RawValue
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: {$0.id == categoryId }) {
            return category.icon
        } else {
            return .question
        }
    }
    
    var month : String {
        return dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType: String {
    case debit = "Debit"
    case credit = "Credit"
    
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryID: Int? = nil
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Auto And Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills and Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees and Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food and dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryID: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryID: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt, mainCategoryID: 2)
    static let moviesAndDVD = Category(id: 301, name: "Movies And DVD", icon: .film, mainCategoryID: 3)
    static let bankFees = Category(id: 401, name: "Bank Fees", icon: .hand_holding_usd, mainCategoryID: 4)
    static let financeCharges = Category(id: 402, name: "Finance Charges", icon: .hand_holding_usd, mainCategoryID: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_basket, mainCategoryID: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .utensils, mainCategoryID: 5)
    static let rent = Category(id: 601, name: "rent", icon: .house_user, mainCategoryID: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryID: 6)
    static let payCheque = Category(id: 701, name: "Pay Cheque", icon: .dollar_sign, mainCategoryID: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryID: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryID: 9)
    
}

extension Category {
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer,
    ]
    
    static let subCategores: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVD,
        .bankFees,
        .financeCharges,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .payCheque,
        .software,
        .creditCardPayment,
    ]
    
    static let all: [Category] = categories + subCategores
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
        
    }
}

extension Double  {
    func roundedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
