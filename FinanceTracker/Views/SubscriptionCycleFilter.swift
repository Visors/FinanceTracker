//
//  SubscriptionCycleFilter.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

// Views/SubscriptionCycleFilter.swift
import SwiftUI

// 优化后的SubscriptionCycleFilter
struct SubscriptionCycleFilter: View {
    @Binding var selectedCycle: SubscriptionCycle?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(SubscriptionCycle.allCases, id: \.self) { cycle in
                    Button {
                        withAnimation(.spring) {
                            selectedCycle = (selectedCycle == cycle) ? nil : cycle
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: cycle.icon)
                                .symbolVariant(.fill)
                            
                            Text(cycle.rawValue)
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(selectedCycle == cycle ? .blue : .gray.opacity(0.15))
                        )
                        .foregroundStyle(selectedCycle == cycle ? .white : .primary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
    }
}
