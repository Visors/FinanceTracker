//
//  Transaction.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import Foundation

// 添加交易类型枚举
enum TransactionType: String, CaseIterable {
    case expense = "支出"
    case income = "收入"
}

// 订阅类型
enum SubscriptionCycle: String, CaseIterable {
    case monthly = "月付"
    case quarterly = "季付"
    case annual = "年付"
    case lifetime = "终身"
    
    var icon: String {
        switch self {
        case .monthly: return "calendar.badge.clock"
        case .quarterly: return "calendar"
        case .annual: return "giftcard"
        case .lifetime: return "infinity"
        }
    }
    
    var duration: String {
        switch self {
        case .monthly: return "/月"
        case .quarterly: return "/季"
        case .annual: return "/年"
        case .lifetime: return "永久"
        }
    }
}


// 添加分类系统
enum TransactionCategory: String, CaseIterable {
    case food = "餐饮"
    case shopping = "购物"
    case transportation = "交通"
    case salary = "薪资"
    case investment = "投资"
    case subscription = "订阅"
    
    var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .shopping: return "bag"
        case .transportation: return "car"
        case .salary: return "dollarsign.arrow.circlepath"
        case .investment: return "chart.line.uptrend.xyaxis"
        case .subscription: return "creditcard.and.arrows"
        }
    }
}




struct Transaction: Identifiable {
    let id = UUID()
    let amount: Double
    let type: TransactionType
    let category: TransactionCategory
    let date: Date
    let note: String
    let subscriptionCycle: SubscriptionCycle?
    
    static let mockData = [
        Transaction(
            amount: 28.5,
            type: .expense,
            category: .food,
            date: .now.addingTimeInterval(-86400*3), // 使用Date()初始化器
            note: "午餐"
        ),
        Transaction(
            amount: 199,
            type: .expense,
            category: .subscription,
            date: .now.addingTimeInterval(-86400*4), // 替换原来的.now写法
            note: "会员"
        ),
        Transaction(
            amount: 28.5,
            type: .expense,
            category: .food,
            date: .now.addingTimeInterval(-86400*2),
            note: "午餐便当"
        ),
        Transaction(
            amount: 4500,
            type: .income,
            category: .salary,
            date: .now.addingTimeInterval(-86400*5),
            note: "二月工资"
        ),
        Transaction(
            amount: 199,
            type: .expense,
            category: .subscription,
            date: .now.addingTimeInterval(-86400*4),
            note: "视频会员",
            subscriptionCycle: .monthly // 添加周期参数
        ),
        Transaction(
            amount: 588,
            type: .expense,
            category: .subscription,
            date: .now.addingTimeInterval(-86400*90),
            note: "云存储",
            subscriptionCycle: .annual
        )
    ]
    
    init(
        amount: Double,
        type: TransactionType,
        category: TransactionCategory,
        date: Date,
        note: String,
        subscriptionCycle: SubscriptionCycle? = nil
    ) {
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.note = note
        self.subscriptionCycle = subscriptionCycle
    }
    
    // 金额格式化方法
    func formattedAmount() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

