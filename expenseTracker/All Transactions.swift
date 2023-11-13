//
//  All Transactions.swift
//  ExpenseTracker
//
//  Created by Admin on 13/11/23.
//

import SwiftUI

struct AllTransactions: View {
    
    @EnvironmentObject var transactionsVM: TransactionViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionsVM.groupTransactionsByMonth()), id: \.key) { month,
                    transactions in
                    
                    Section {
                        ForEach(transactions) { monthlyTransactions in
                            TransactionRow(transaction: monthlyTransactions)
                        }
                        .padding(.top)
                    } header: {
                        Text(month)
                            .padding([.bottom, .top])
                    }
                    .listSectionSeparator(.hidden)
                    
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.primary)
    }
}

struct All_Transactions_Previews: PreviewProvider {
    
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    
    static var previews: some View {
        NavigationView {
            AllTransactions()
                .environmentObject(transactionsDummyList)
        }
    }
}
