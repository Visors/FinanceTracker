//
//  SubscriptionSection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct SubscriptionSection: View {
    @Binding var subscriptionCycle: SubscriptionCycle?
    let showSubscription: Bool
    
    var body: some View {
        Section {
            if showSubscription {
                Picker("订阅周期", selection: $subscriptionCycle) {
                    Text("无周期").tag(SubscriptionCycle?.none)
                    ForEach(SubscriptionCycle.allCases, id: \.self) { cycle in
                        Label(cycle.rawValue, systemImage: cycle.icon)
                            .tag(cycle as SubscriptionCycle?)
                    }
                }
            }
        }
    }
}

#Preview {
    SubscriptionSection(
        subscriptionCycle: .constant(.monthly),
        showSubscription: true
    )
}
