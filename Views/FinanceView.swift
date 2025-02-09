//
//  FinanceView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct FinanceView: View {
    // 临时假数据
    let sampleTransactions = [
        Transaction(amount: 28.5, category: "餐饮", date: .now, note: "午餐便当"),
        Transaction(amount: 199, category: "订阅", date: .now, note: "网易云会员"),
        Transaction(amount: 15, category: "交通", date: .now, note: "地铁通勤")
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(sampleTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            } header: {
                QuickAddToolbar()
            }
        }
        .navigationTitle("财务记录")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("手动记账") { /* 待实现 */ }
                    Button("导入截图") { /* 待实现 */ }
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .background(Color.background)
    }
}

// 交易记录行组件




// 快速添加工具栏
struct QuickAddToolbar: View {
    var body: some View {
        HStack {
            ForEach(["餐饮", "交通", "购物"], id: \.self) { category in
                Button {
                    // 快速记账逻辑
                } label: {
                    Text(category)
                        .padding(8)
                        .background(Color.sakuraPink)
                        .clipShape(Capsule())
                }
            }
        }
        .buttonStyle(.plain)
    }
}
