//
//  TransactionRow.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

// 更新TransactionRow.swift
struct TransactionRow: View {
    let transaction: Transaction
    
    var amountColor: Color {
        transaction.type == .income ? .green : .red
    }
    
    var body: some View {
        HStack {
            Image(systemName: transaction.category.icon)
                .foregroundStyle(amountColor)
            
            VStack(alignment: .leading) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                
                Text(transaction.note)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(transaction.formattedAmount())
                    .foregroundStyle(amountColor)
                    .fontWeight(.medium)
                
                Text(transaction.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}


