//
//  PreviewData.swift
//  fold
//
//  Created by Admin on 12/11/23.
//

import Foundation

var TransactionPreviewData = Transaction(id: 1, date: "01/01/24", institution: "Hello", account: "HDFC Bank", merchant: "Sabji wala", amount: 20.0, categoryID: 801, category: "Vegetables", isPending: false, isTransfer: false, isExpense: true,type: TransactionType.debit.rawValue)

var transactionslist = [Transaction](repeating: TransactionPreviewData, count: 25)
