//
//  AmountInputSection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

public struct AmountInputSection: View {
    @Binding var amount: String
    @FocusState private var isFocused: Bool
    
    public init(amount: Binding<String>) {
        self._amount = amount
    }
    
    public var body: some View {
        Section {
            HStack(spacing: 8) {
                Text("¥")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                
                TextField("0.00", text: $amount)
                    .focused($isFocused)
                    #if os(iOS)
                    .keyboardType(.decimalPad)
                    #endif
                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
                    .multilineTextAlignment(.trailing)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 8)
            .animation(.easeInOut(duration: 0.2), value: isFocused)
        } header: {
            Text("金额")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .headerProminence(.increased)
    }
}

#Preview {
    VStack {
        AmountInputSection(amount: .constant(""))
//        AmountInputSection(amount: .constant("256.80"))
    }
    .padding()
}
