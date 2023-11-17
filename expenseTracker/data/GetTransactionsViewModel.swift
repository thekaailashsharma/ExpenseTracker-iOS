//
//  GetTransactionsViewModel.swift
//  ExpenseTracker
//
//  Created by Admin on 17/11/23.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Date: [GetTransactions]] = [:]

    private var fetchedResultsController: NSFetchedResultsController<GetTransactions>

    init() {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]

        self.fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: /* Your managed object context here */,
            sectionNameKeyPath: "date",
            cacheName: nil
        )

        do {
            try fetchedResultsController.performFetch()
            updateTransactions()
        } catch {
            print("Error fetching results: \(error.localizedDescription)")
        }
    }

    private func updateTransactions() {
        guard let sections = fetchedResultsController.sections else { return }

        var transactionsDict: [Date: [TransactionEntity]] = [:]

        for section in sections {
            let transactionsInSection = section.objects as! [TransactionEntity]
            if let date = transactionsInSection.first?.date {
                transactionsDict[date] = transactionsInSection
            }
        }

        transactions = transactionsDict
    }
}


