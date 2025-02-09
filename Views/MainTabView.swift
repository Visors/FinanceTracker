//
//  MainTabView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FinanceView()
            }
            .tabItem {
                Label("账目", systemImage: "dollarsign.circle")
            }
            
            NavigationStack {
                SubscriptionView()
            }
            .tabItem {
                Label("订阅", systemImage: "calendar")
            }
            
            NavigationStack {
                ReportView()
            }
            .tabItem {
                Label("报表", systemImage: "chart.pie")
            }
        }
        .tint(.sakuraRed)
    }
}
