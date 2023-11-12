//
//  foldApp.swift
//  fold
//
//  Created by Admin on 11/11/23.
//

import SwiftUI

@main
struct expenseTracker: App {
    
    @StateObject var transactionViewModel = TransactionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionViewModel)
        }
    }
}
