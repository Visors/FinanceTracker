//
//  Transaction.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI
import Foundation

// MARK: - 交易类型
public enum TransactionType: String, CaseIterable, Codable {
    
    case income = "收入"
    case expense = "支出"
        
    public var icon: String {
        switch self {
        case .income: return "arrow.down.circle"
        case .expense: return "arrow.up.circle"
        }
    }
        
    public var color: Color {
        self == .income ? .green : .red
    }
}

// MARK: - 订阅周期
public enum SubscriptionCycle: String, CaseIterable, Codable {
    case monthly = "月付"
    case quarterly = "季付"
    case annual = "年付"
    case lifetime = "终身"
    
    var icon: String {
        switch self {
        case .monthly: return "calendar"
        case .quarterly: return "chart.bar.fill"
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

// MARK: - 交易分类
public enum TransactionCategory: String, CaseIterable, Codable {
    case food = "餐饮"
    case shopping = "购物"
    case transportation = "交通"
    case salary = "工资"
    case investment = "投资"
    case subscription = "订阅"
    
    public var color: Color {
        switch self {
        case .food: return .orange          // 餐饮-橙色（食欲/食物）
        case .shopping: return .pink        // 购物-粉色（时尚/消费）
        case .transportation: return .blue  // 交通-蓝色（出行/运输）
        case .salary: return .green         // 工资-绿色（收入/增长）
        case .investment: return .indigo    // 投资-靛蓝（专业/金融）
        case .subscription: return .purple  // 订阅-紫色（定期/服务）
        }
    }
    
    public var icon: String {
        switch self {
        case .food: return "fork.knife"
        case .shopping: return "bag"
        case .transportation: return "car"
        case .salary: return "dollarsign.arrow.circlepath"
        case .investment: return "chart.line.uptrend.xyaxis"
        case .subscription: return "creditcard"
        }
    }
}


// MARK: - 交易结构体
struct Transaction: Identifiable, Codable {
    let id: UUID
    let amount: Double
    let type: TransactionType
    let category: TransactionCategory
    let date: Date
    let note: String
    let subscriptionCycle: SubscriptionCycle?
    
    // 改进后的初始化方法
    init(
        id: UUID = UUID(),
        amount: Double,
        type: TransactionType,
        category: TransactionCategory,
        date: Date = Date(),
        note: String = "",
        subscriptionCycle: SubscriptionCycle? = nil
    ) {
        self.id = id
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.note = note
        self.subscriptionCycle = subscriptionCycle
    }
}

// MARK: - 扩展功能
extension Transaction {
    static let mockData: [Transaction] = [
        Transaction(
            amount: 28.5,
            type: .expense,
            category: .food,
            date: Date().addingTimeInterval(-86400*3),
            note: "午餐"
        ),
        Transaction(
            amount: 199,
            type: .expense,
            category: .subscription,
            date: Date().addingTimeInterval(-86400*4),
            note: "视频会员",
            subscriptionCycle: .monthly
        ),
        Transaction(
            amount: 4500,
            type: .income,
            category: .salary,
            date: Date().addingTimeInterval(-86400*5),
            note: "二月工资"
        ),
        Transaction(
            amount: 588,
            type: .expense,
            category: .subscription,
            date: Date().addingTimeInterval(-86400*90),
            note: "云存储服务",
            subscriptionCycle: .annual
        )
    ]
}

// MARK: - 金额格式化扩展
extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%.2f", self)
    }
}
