//
//  RecentTransactions.swift
//  ExpenseTracker
//
//  Created by Admin on 13/11/23.
//

import SwiftUI

struct RecentTransactions: View {
    
    @EnvironmentObject var transactionsVM: TransactionViewModel
    
    var body: some View {
        
            VStack {
                ScrollView {
                HStack {
                    Text("Recent Transactions")
                        .bold()
                    
                    Spacer()
                    
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Text("See all")
                            Image(systemName: "chevron.right")
                        }.foregroundColor(.textColor)
                    }
                    
                }
                .padding(.top)
                
                // List
                
                    ForEach(Array(transactionsVM.transaction.prefix(5).enumerated()), id: \.element) { index, transaction in
                        TransactionRow(transaction: transaction)
                        
                        Divider()
                            .opacity(index == 4 ? 0 : 1)
                }
            }
            .padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .primary.opacity(0.2), radius: 10, x: 5, y: 5)
        }
    }
}

struct RecentTransactions_Previews: PreviewProvider {
    
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    
    static var previews: some View {
        RecentTransactions()
            .environmentObject(transactionsDummyList)
    }
}


struct RecentTransactions_Previews_Dark: PreviewProvider {
    
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    
    static var previews: some View {
        RecentTransactions()
            .environmentObject(transactionsDummyList)
    }
}
