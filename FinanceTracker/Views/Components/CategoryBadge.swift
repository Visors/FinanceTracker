//
//  CategoryBadge.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

// 分类徽章组件
struct CategoryBadge: View {
    let category: String
    
    var body: some View {
        Text(category.prefix(2))
            .font(.caption)
            .frame(width: 36, height: 36)
            .background(
                Circle()
                    .fill(Color.sakuraPink)
                    .shadow(radius: 2)
            )
            .foregroundColor(.sakuraBrown)
    }
}
