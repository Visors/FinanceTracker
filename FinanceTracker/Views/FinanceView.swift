//
//  FinanceView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct FinanceView: View {
    @State private var transactions = Transaction.mockData
    
    var body: some View {
        NavigationStack {
            List(transactions) { transaction in
                TransactionRow(transaction: transaction)
                    .transactionRowStyle(for: transaction.type)
            }
            .navigationTitle("所有交易")
            .toolbar {
                // macOS适配
                #if os(macOS)
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        SubscriptionView()
                    } label: {
                        Label("订阅管理", systemImage: "creditcard.and.arrows")
                            .labelStyle(.titleAndIcon)
                    }
                }
                #else
                // iOS/iPadOS适配
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SubscriptionView()
                    } label: {
                        Text("订阅管理")
                            .font(.subheadline.weight(.medium))
                    }
                }
                #endif
            }
        }
    }
}

// 交易行样式修饰器
struct TransactionRowStyle: ViewModifier {
    let type: TransactionType
    
    func body(content: Content) -> some View {
        content
            .listRowBackground(
                RoundedRectangle(cornerRadius: 8)
                    .fill(type == .income ? Color.green.opacity(0.1) : Color.clear)
            )
    }
}

extension View {
    func transactionRowStyle(for type: TransactionType) -> some View {
        modifier(TransactionRowStyle(type: type))
    }
}



// 摘要项组件
struct SummaryItemView: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(value.formattedAsCurrency())
                .font(.title3.weight(.medium))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
    }
}

// 金额格式化扩展
extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

#Preview("默认预览") {
    FinanceView()
}

#Preview("含订阅交易") {
    let transactions = [
        Transaction(
            amount: 199,
            type: .expense,
            category: .subscription,
            date: .now,
            note: "视频会员",
            subscriptionCycle: .monthly
        ),
        Transaction(
            amount: 588,
            type: .expense,
            category: .subscription,
            date: .now,
            note: "云存储",
            subscriptionCycle: .annual
        )
    ]
    
    FinanceView()
}
