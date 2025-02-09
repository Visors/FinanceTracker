//
//  TypeCategorySection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct TypeCategorySection: View {
    @Binding var selectedType: TransactionType
    @Binding var selectedCategory: TransactionCategory
    
    var body: some View {
        Section("分类信息") {
            Picker("交易类型", selection: $selectedType) {
                ForEach(TransactionType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("分类", selection: $selectedCategory) {
                ForEach(TransactionCategory.allCases, id: \.self) { category in
                    Label(category.rawValue, systemImage: category.icon)
                        .tag(category)
                }
            }
        }
    }
}

#Preview {
    TypeCategorySection(
        selectedType: .constant(.expense),
        selectedCategory: .constant(.food)
    )
}

