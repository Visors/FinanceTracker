//
//  DataManager.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import Foundation

class DataManager: ObservableObject {
    @Published var transactions: [Transaction] = Transaction.mockData
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}
