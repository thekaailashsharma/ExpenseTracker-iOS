//
//  Transactions.swift
//  fold
//
//  Created by Admin on 12/11/23.
//

import Foundation

struct Transaction : Identifiable, Decodable {
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
}

enum TransactionType: String {
    case debit = "Debit"
    case credit = "Credit"
    
}


