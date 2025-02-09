//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

struct AddTransactionView: View {
    // MARK: - 数据绑定
    @State private var amount: String = ""
    @State private var selectedType: TransactionType = .expense
    @State private var selectedCategory: TransactionCategory = .food
    @State private var subscriptionCycle: SubscriptionCycle?
    @State private var note: String = ""
    
    // MARK: - 环境依赖
    @EnvironmentObject private var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 主视图
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("新增记录")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("取消") { /* 关闭逻辑 */ }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("保存") { /* 保存逻辑 */ }
                            .disabled(amount.isEmpty)
                    }
                }
        }
        #if os(macOS)
        .frame(minWidth: 400, idealWidth: 500, maxWidth: 600, minHeight: 500)
        #endif
    }
    
    private var content: some View {
        ScrollView {
            VStack(spacing: platformSpecificSpacing) {
                AmountInputSection(amount: $amount)
                    .sectionPadding()
                    
                TypeCategorySection(
                    selectedType: $selectedType,
                    selectedCategory: $selectedCategory
                )
                    .sectionPadding()
                        
                SubscriptionSection(
                    subscriptionCycle: $subscriptionCycle,
                    showSubscription: selectedCategory == .subscription
                )
                    .sectionPadding()
                        
                NoteSection(note: $note)
                    .sectionPadding()
            }
                .globalPadding()
                .modifier(AdaptivePaddingModifier())
        }.scrollDisabled(!shouldEnableScroll)
        #if os(macOS)
        .scrollIndicators(.never)
        #endif
    }
        
    // 平台相关参数
    private var formPadding: CGFloat {
        #if os(macOS)
        return 20
        #else
        return 0
        #endif
    }
        
    private var platformSpecificSpacing: CGFloat {
        #if os(macOS)
        return 25
        #else
        return 20
        #endif
    }
    
    private var shouldEnableScroll: Bool {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .phone
        #else
        return true
        #endif
    }
    
    // MARK: - 保存逻辑
    private func saveTransaction() {
        guard let amountValue = Double(amount) else {
            // 这里可以添加错误提示
            return
        }
        
        let newTransaction = Transaction(
            amount: amountValue,
            type: selectedType,
            category: selectedCategory,
            date: Date(),
            note: note,
            subscriptionCycle: selectedCategory == .subscription ? subscriptionCycle : nil
        )
        
        dataManager.addTransaction(newTransaction)
        dismiss()
    }
}

// MARK: - 扩展
extension View {
    func sectionPadding() -> some View {
        modifier(SectionPaddingModifier())
    }
    
    func globalPadding() -> some View {
        modifier(GlobalPaddingModifier())
    }
}

// 平台自适应边距修饰符
struct SectionPaddingModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, platformSectionPadding)
    }
    
    private var platformSectionPadding: CGFloat {
        #if os(macOS)
        return 20
        #else
        return UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16
        #endif
    }
}

struct GlobalPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 20)
            .padding(.horizontal, globalHorizontalPadding)
    }
    
    private var globalHorizontalPadding: CGFloat {
        #if os(macOS)
        return 0
        #else
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 32
        } else {
            return 0 // 减少iPhone的左右边距
        }
        #endif
    }
}


struct AdaptivePaddingModifier: ViewModifier {
    @State private var viewWidth: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, calculatedPadding)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ViewWidthKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(ViewWidthKey.self) { width in
                viewWidth = width
            }
    }
    
    private var calculatedPadding: CGFloat {
        if viewWidth > 800 {
            return 32
        } else if viewWidth > 400 {
            return 24
        } else {
            return 16
        }
    }
}

struct ViewWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - 预览
#Preview {
    AddTransactionView()
        .environmentObject(DataManager())
}

// MARK: - 组件预览补充
#Preview("输入组件") {
    List {
        AmountInputSection(amount: .constant("100.00"))
        TypeCategorySection(
            selectedType: .constant(.expense),
            selectedCategory: .constant(.subscription)
        )
        SubscriptionSection(
            subscriptionCycle: .constant(.monthly),
            showSubscription: true
        )
        NoteSection(note: .constant("测试备注"))
    }
}
