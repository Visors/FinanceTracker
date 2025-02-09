//
//  TypeCategorySection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

public struct TypeCategorySection: View {
    @Binding var selectedType: TransactionType
    @Binding var selectedCategory: TransactionCategory
    
    public init(selectedType: Binding<TransactionType>,
                selectedCategory: Binding<TransactionCategory>) {
        self._selectedType = selectedType
        self._selectedCategory = selectedCategory
    }
    
    public var body: some View {
        Section {
            typeSelector
            categorySelector
        } header: {
            Text("类型与分类")
                .font(.headline)
                .foregroundColor(.primary)
        }
        .headerProminence(.increased)
    }
    
    // 分解后的类型选择视图
    private var typeSelector: some View {
        HStack(spacing: 12) {
            ForEach(TransactionType.allCases, id: \.self) { type in
                TypeButton(
                    isSelected: selectedType == type,
                    systemImage: type.icon,
                    title: type.rawValue,
                    color: type.color
                ) {
                    selectedType = type
                }
            }
        }
    }
    
    // 分解后的分类选择视图
    private var categorySelector: some View {
        Group {
            if shouldUseScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    categoryContent
                }
            } else {
                categoryContent
            }
        }
    }
    
    private var categoryContent: some View {
        HStack(spacing: 10) {
            ForEach(TransactionCategory.allCases, id: \.self) { category in
                CategoryTag(
                    isSelected: selectedCategory == category,
                    title: category.rawValue,
                    color: category.color
                ) {
                    selectedCategory = category
                }
                .fixedSize() // 防止标签被压缩
            }
        }
        .padding(.vertical, 4)
    }
    
    private var shouldUseScrollView: Bool {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .phone
        #else
        return false
        #endif
    }
}


private struct TypeButton: View {
    let isSelected: Bool
    let systemImage: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
            Button(action: action) {
                VStack(spacing: 8) {
                    Image(systemName: systemImage)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(isSelected ? .white : color)
                        .frame(width: 40, height: 40)
                        .background(isSelected ? color : color.opacity(0.2))
                        .clipShape(Circle())
                    
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isSelected ? color : .primary)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.controlBackground) // 使用统一背景色
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? color : Color.clear, lineWidth: 2)
                        )
                )
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(RoundedRectangle(cornerRadius: 12))
        }
}

private struct CategoryTag: View {
    let isSelected: Bool
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(isSelected ? .white : color)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(isSelected ? color : color.opacity(0.15))
                            .background(
                                Capsule()
                                    .fill(Color.controlBackground) // 底层背景
                            )
                    )
                    .overlay(
                        Capsule()
                            .stroke(color.opacity(0.3), lineWidth: isSelected ? 0 : 1)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Capsule())
        }
}

extension Color {
    static var controlBackground: Color {
        #if os(macOS)
        return Color(NSColor.controlBackgroundColor)
        #else
        return Color(UIColor.secondarySystemBackground)
        #endif
    }
}


#Preview {
    TypeCategorySection(
        selectedType: .constant(.expense),
        selectedCategory: .constant(.food)
    )
    .padding()
}

