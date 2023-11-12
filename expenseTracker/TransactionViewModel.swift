//
//  TransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Admin on 12/11/23.
//

import Foundation
import Combine

final class TransactionViewModel: ObservableObject {
    @Published var transaction : [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error) : print("Error is \(error)")
                case .finished : print("Finished")
                }
            } receiveValue: { [weak self] result in
                dump(result)
                self?.transaction = result
            }
            .store(in: &cancellables)

    }
}
