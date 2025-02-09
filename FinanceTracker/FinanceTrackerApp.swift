//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

// FinanceTrackerApp.swift
import SwiftUI

@main
struct FinanceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .tint(.sakuraRed) // 使用新的颜色系统
                .background(Color.background) // 添加全局背景
                .environmentObject(DataManager())
        }
    }
}

// 使用新的跨平台颜色API（Xcode 16+）
extension Color {
    static let sakuraPink = Color(red: 0.98, green: 0.85, blue: 0.90)
    static let sakuraRed = Color(red: 0.92, green: 0.34, blue: 0.39)
    static let sakuraBrown = Color(red: 0.45, green: 0.33, blue: 0.31)
    
    static let background = Color.sakuraPink.opacity(0.1) // 使用现有颜色派生
}

