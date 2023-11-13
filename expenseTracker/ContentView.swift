//
//  ContentView.swift
//  fold
//
//  Created by Admin on 11/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    RecentTransactions()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .renderingMode(.original)
                        .foregroundStyle(Color.iconColor, .primary)
                    
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews_Light: PreviewProvider {
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionsDummyList)
    }
}

struct ContentView_Previews_Dark: PreviewProvider {
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionsDummyList)
    }
}
