//
//  MainTabView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct MainTabView: View {
    #if os(macOS)
    @State private var selectedCategory: NavigationCategory? = .finance
    #endif
    
    // 定义导航分类枚举（用于macOS侧边栏）
    enum NavigationCategory: String, CaseIterable {
        case finance = "dollarsign.circle"
        case subscriptions = "creditcard"
        case analytics = "chart.bar"
        case settings = "gearshape"
        
        var title: String {
            switch self {
            case .finance: return "财务记录"
            case .subscriptions: return "订阅管理"
            case .analytics: return "统计报表"
            case .settings: return "系统设置"
            }
        }
    }
    
    var body: some View {
        #if os(macOS)
        // macOS版本使用NavigationSplitView
        NavigationSplitView {
            List(selection: $selectedCategory) {
                ForEach(NavigationCategory.allCases, id: \.self) { category in
                    NavigationLink {
                        contentView(for: category)
                    } label: {
                        Label(category.title, systemImage: category.rawValue)
                    }
                    .tag(category)
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("功能导航")
        } detail: {
            if let category = selectedCategory {
                contentView(for: category)
            } else {
                Text("请选择功能模块")
                    .foregroundStyle(.secondary)
            }
        }
        #else
        // iOS版本使用常规TabView
        TabView {
            NavigationStack {
                FinanceView()
            }
            .tabItem {
                Label("财务", systemImage: "dollarsign.circle")
            }
            .tag(NavigationCategory.finance)
            
            NavigationStack {
                SubscriptionView()
            }
            .tabItem {
                Label("订阅", systemImage: "creditcard")
            }
            .tag(NavigationCategory.subscriptions)
            
            NavigationStack {
                AnalyticsView()
            }
            .tabItem {
                Label("统计", systemImage: "chart.bar")
            }
            .tag(NavigationCategory.analytics)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("设置", systemImage: "gearshape")
            }
            .tag(NavigationCategory.settings)
        }
        .tint(.sakuraRed)
        #endif
    }
    
    // 根据导航类型返回对应视图
    @ViewBuilder
    private func contentView(for category: NavigationCategory) -> some View {
        switch category {
        case .finance:
            FinanceView()
        case .subscriptions:
            SubscriptionView()
        case .analytics:
            AnalyticsView()
        case .settings:
            SettingsView()
        }
    }
}

// MARK: - 预览视图
#Preview("iOS") {
    MainTabView().environmentObject(DataManager())
        
}

#Preview("macOS") {
    MainTabView()
        .frame(width: 1200, height: 800).environmentObject(DataManager())
}
