//
//  AmountInputSection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct AmountInputSection: View {
    @Binding var amount: String
    
    var body: some View {
        Section("金额") {
            TextField("0.00", text: $amount)
                .keyboardType(.decimalPad)
                .font(.title2.weight(.semibold))
                .multilineTextAlignment(.trailing)
                .padding(.vertical, 8)
        }
    }
}

#Preview {
    AmountInputSection(amount: .constant("100.00"))
}

