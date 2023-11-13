//
//  ChartView.swift
//  ExpenseTracker
//
//  Created by Admin on 13/11/23.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    @EnvironmentObject var transactionVM: TransactionViewModel
    
    var body: some View {
        
        let data = transactionVM.accumulateTransactions()
        let totalExpenses = data.last?.1 ?? 0
        
        if !data.isEmpty {

            CardView {
                VStack(alignment: .leading) {
                    ChartLabel(totalExpenses.formatted(.currency(code: "USD")),
                               type: .title, format: "$%.02f")
                    LineChart()
                }
                .background(Color.systemBackground)
            }.data(transactionVM.accumulateTransactions())
                .chartStyle(ChartStyle(backgroundColor: .background,
                                       foregroundColor: ColorGradient(.iconColor.opacity(0.8), .iconColor.opacity(0.4))))
                .background(Color.systemBackground)
                .frame(height: 300)
                .shadow(color: .background, radius: 0)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    
    static let transactionsDummyList: TransactionViewModel = {
        let transactionsDummyList = TransactionViewModel()
        transactionsDummyList.transaction = transactionslist
        return transactionsDummyList
    }()
    static var previews: some View {
        ChartView()
            .environmentObject(transactionsDummyList)
    }
}
