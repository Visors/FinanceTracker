//
//  FinanceView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

private struct SummaryHeader: View {
    @EnvironmentObject var dataManager: DataManager
    
    var totalIncome: Double {
        dataManager.transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        dataManager.transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    var balance: Double {
        totalIncome - totalExpense
    }
    
    var body: some View {
        HStack(spacing: 16) {
            SummaryItemView(
                title: "总收入",
                value: totalIncome,
                color: .green
            )
            
            Divider()
                .frame(height: 40)
            
            SummaryItemView(
                title: "总支出",
                value: totalExpense,
                color: .red
            )
            
            Divider()
                .frame(height: 40)
            
            SummaryItemView(
                title: "当前结余",
                value: balance,
                color: balance >= 0 ? .blue : .orange
            )
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.regularMaterial)
        )
    }
}

struct FinanceView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SummaryHeader()
                    .padding(.horizontal)
                    .background(.background)
                List {
                    ForEach(dataManager.transactions) { transaction in
                        TransactionRow(transaction: transaction)
                            .transactionRowStyle(for: transaction.type)
                    }
                    .onDelete(perform: deleteTransaction)  // 添加删除功能
                }
                .navigationTitle("所有交易")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        NavigationLink {
                            AddTransactionView()
                        } label: {
                            Image(systemName: "plus")
                                .symbolVariant(.circle.fill)
                        }
                        
                        NavigationLink {
                            SubscriptionView()
                        } label: {
                            Label("订阅管理", systemImage: "creditcard.and.arrows")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
    }
    
    private func deleteTransaction(at offsets: IndexSet) {
        dataManager.deleteTransaction(at: offsets)
    }
}



// 交易行样式修饰器
struct TransactionRowStyle: ViewModifier {
    let type: TransactionType
    
    func body(content: Content) -> some View {
        content
            .listRowSeparatorTint(.secondary.opacity(0.3))
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .fill(type == .income ?
                        Color.green.opacity(0.08) :
                        Color.clear)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
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


// 修改后的预览部分
#Preview("默认预览") {
    FinanceView()
        .environmentObject(DataManager())
}

#Preview("含订阅交易") {
    let manager = DataManager()
    manager.transactions = [
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
    return FinanceView()
        .environmentObject(manager)
}

