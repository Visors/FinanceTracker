//
//  SubscriptionSection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

public struct SubscriptionSection: View {
    @Binding var subscriptionCycle: SubscriptionCycle?
    let showSubscription: Bool
    
    public init(subscriptionCycle: Binding<SubscriptionCycle?>,
                showSubscription: Bool) {
        self._subscriptionCycle = subscriptionCycle
        self.showSubscription = showSubscription
    }
    
    public var body: some View {
            if showSubscription {
                VStack(alignment: .leading, spacing: 4) {
                    sectionHeader
                    subscriptionButtons
                }
                .sectionPadding()
                .background(
                    GeometryReader{ proxy in
                        Color.clear
                            .preference(key: SubscriptionHeightKey.self, value: proxy.size.height)
                    }
                )
            }
        }
        
        // MARK: - 子视图
        private var sectionHeader: some View {
            Text("订阅周期")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 4)
        }
        
        private var subscriptionButtons: some View {
            Group {
                if shouldUseScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        buttonsHStack
                    }
                } else {
                    buttonsHStack
                }
            }
        }
        
        private var buttonsHStack: some View {
            HStack(spacing: buttonSpacing) {
                ForEach(SubscriptionCycle.allCases, id: \.self) { cycle in
                    CycleButton(
                        cycle: cycle,
                        isSelected: subscriptionCycle == cycle,
                        action: { subscriptionCycle = cycle }
                    )
                }
            }
            .padding(.vertical, 4)
        }
        
        // MARK: - 布局参数
        private var shouldUseScrollView: Bool {
            #if os(iOS)
            return UIDevice.current.userInterfaceIdiom == .phone
            #else
            return false
            #endif
        }
        
        private var buttonSpacing: CGFloat {
            #if os(iOS)
            return UIDevice.current.userInterfaceIdiom == .pad ? 16 : 12
            #else
            return 14
            #endif
        }
    }

    struct CycleButton: View {
        let cycle: SubscriptionCycle
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
                Button(action: action) {
                    buttonContent
                        .background(backgroundStyle)
                        .overlay(borderOverlay)
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            private var buttonContent: some View {
                HStack(spacing: 4) {
                    Text(cycle.rawValue)
                        .font(.subheadline)
                        .fixedSize()
                        .lineLimit(1)
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
                .foregroundColor(isSelected ? .blue : .primary)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, 10)
                .frame(minWidth: minButtonWidth)
                .contentShape(RoundedRectangle(cornerRadius: 8))
            }
            
            private var backgroundStyle: some View {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.08))
                    #if os(macOS)
                    .shadow(color: .gray.opacity(0.1), radius: 1, x: 0, y: 1)
                    #endif
            }
            
            private var borderOverlay: some View {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: 1)
            }
            
            // MARK: - 平台参数
            private var minButtonWidth: CGFloat {
                #if os(iOS)
                return UIDevice.current.userInterfaceIdiom == .pad ? 110 : 84
                #else
                return 100
                #endif
            }
            
            private var horizontalPadding: CGFloat {
                #if os(iOS)
                return UIDevice.current.userInterfaceIdiom == .pad ? 16 : 12
                #else
                return 14
                #endif
            }
        }

struct SubscriptionHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    SubscriptionSection(
        subscriptionCycle: .constant(.monthly),
        showSubscription: true
    )
    .padding()
}

//import SwiftUI
//
//public struct SubscriptionSection: View {
//    @Binding var subscriptionCycle: SubscriptionCycle?
//    let showSubscription: Bool
//    
//    public init(subscriptionCycle: Binding<SubscriptionCycle?>,
//                showSubscription: Bool) {
//        self._subscriptionCycle = subscriptionCycle
//        self.showSubscription = showSubscription
//    }
//    
//    public var body: some View {
//        if showSubscription {
//            Section {
//                VStack(spacing: 12) {
//                    Text("订阅周期")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    HStack(spacing: 12) {
//                        ForEach(SubscriptionCycle.allCases, id: \.self) { cycle in
//                            CycleOption(
//                                isSelected: subscriptionCycle == cycle,
//                                cycle: cycle
//                            ) {
//                                subscriptionCycle = (subscriptionCycle == cycle) ? nil : cycle
//                            }
//                        }
//                    }
//                }
//                .padding(.vertical, 8)
//            }
//            .headerProminence(.increased)
//            .transition(.opacity)
//        }
//    }
//}
//
//private struct CycleOption: View {
//    let isSelected: Bool
//    let cycle: SubscriptionCycle
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            HStack(spacing: 6) {
//                if isSelected {
//                    Image(systemName: "checkmark.circle.fill")
//                        .foregroundColor(.blue)
//                }
//                
//                Text(cycle.rawValue)
//                    .font(.system(size: 14, weight: .medium))
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 10)
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
//            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
//            )
//        }
//        .buttonStyle(.plain)
//    }
//}
//
//#Preview {
//    SubscriptionSection(
//        subscriptionCycle: .constant(.monthly),
//        showSubscription: true
//    )
//    .padding()
//}
