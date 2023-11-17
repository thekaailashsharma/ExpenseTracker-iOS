//
//  All Transactions.swift
//  ExpenseTracker
//
//  Created by Admin on 13/11/23.
//

import SwiftUI
import CoreData

struct AllTransactions: View {
    
    @EnvironmentObject var transactionsVM: TransactionViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GetTransactions.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<GetTransactions>
    @Environment(\.managedObjectContext) private var viewContext

    
    var body: some View {
        
        VStack {
            List {
                ForEach(groupedTransactions, id: \.0) { month,
                    transactionsInMonth in
                    
                    Section {
                        ForEach(transactionsInMonth, id: \.self) { transaction in
                            TransactionRow(fontIcon: transactionsVM.getFontAwesodeCode(categoryId: Int(transaction.categoryId)), merchant: transaction.merchant ?? "",
                                           category: transaction.category ?? "", dateParsed: transaction.date?.dateParsed() ?? Date(), signedAmount: Int(transaction.amount)
                            )
                        }
                        .padding(.top)
                    } header: {
                        Text(month)
                            .padding([.bottom, .top])
                    }
                    .listSectionSeparator(.hidden)
                    
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.primary)
    }
    
    private var groupedTransactions: [(String, [GetTransactions])] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy" // Month format: January 2023

        let groupedDict = Dictionary(grouping: items) { transaction -> String in
            if let date = transaction.date {
                return dateFormatter.string(from: date.dateParsed())
            }
            return "Unknown Month" // Handle if date is nil
        }

        // Sort the grouped dictionary by keys (months)
        let sortedGroupedTransactions = groupedDict.sorted { (first, second) -> Bool in
            let firstDate = dateFormatter.date(from: first.key) ?? Date()
            let secondDate = dateFormatter.date(from: second.key) ?? Date()
            return firstDate > secondDate
        }

        return sortedGroupedTransactions
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
