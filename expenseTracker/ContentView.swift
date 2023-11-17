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
import SwiftUIFontIcon

struct ContentView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var text = "Continue for verification"
    @AppStorage("isLoginScreenVisible")
    var isLoginScreenVisible: Bool?
    
    var body: some View {
        if (!(isLoginScreenVisible ?? true)) {
            TabView {
                NavigationView {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Overview")
                                .font(.title2)
                                .bold()
                            
                            Button {
                                isLoginScreenVisible = true
                            } label: {
                                if (isLoginScreenVisible ?? true){
                                    Text("true")
                                } else {
                                    Text("false")
                                }
                                
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
                .animation(.easeIn, value: isLoginScreenVisible)
                .navigationViewStyle(.stack)
                .tint(.primary)
                .tabItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "house")
                        Text("Home")
                    }

                }
                
                CreateTransaction()
                    .tabItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "wallet.pass")
                            Text("Home")
                        }
                    }
            }
            .tint(.iconColor)
            
            
        } else {
            LoginUI()
                .animation(.easeIn, value: isLoginScreenVisible)
        }
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
