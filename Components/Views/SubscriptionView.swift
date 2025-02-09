//
//  SubscriptionView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

// 新建 SubscriptionView.swift
struct SubscriptionView: View {
    @State private var selectedCycle: SubscriptionCycle?
    @State private var transactions = Transaction.mockData
    
    var filteredTransactions: [Transaction] {
        transactions.filter {
            $0.category == .subscription &&
            (selectedCycle == nil || $0.subscriptionCycle == selectedCycle)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // 使用优化后的周期过滤器
                SubscriptionCycleFilter(selectedCycle: $selectedCycle)
                    .padding()
                
                List(filteredTransactions) { transaction in
                    SubscriptionTransactionRow(transaction: transaction)
                }
            }
            .navigationTitle("订阅管理")
        }
    }
}

// 专用订阅交易行组件
struct SubscriptionTransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: transaction.category.icon)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading) {
                Text(transaction.note)
                    .font(.headline)
                
                if let cycle = transaction.subscriptionCycle {
                    Text(cycle.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Text(transaction.formattedAmount())
                .foregroundStyle(.red) // 订阅固定为支出
        }
    }
}
