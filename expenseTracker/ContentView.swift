//
//  ContentView.swift
//  fold
//
//  Created by Admin on 11/11/23.
//

import SwiftUI
import AuthenticationServices
import Firebase
import Combine

struct ContentView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var text = "Continue for verification"
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    Button {
                        PhoneAuthProvider.provider()
                            .verifyPhoneNumber("+919326405547", uiDelegate: nil) { verificationID, error in
                              if let error = error {
                                  text = error.localizedDescription
                                  dump(error.localizedDescription)
                                return
                              }
                              text = "OTP Sent"
                          }
                    } label: {
                        Text(text)
                    }


                    ChartView()
                    
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
        .tint(.primary)
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
