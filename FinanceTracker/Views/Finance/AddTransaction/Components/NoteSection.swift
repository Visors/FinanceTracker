//
//  NoteSection.swift
//  FinanceTracker
//
//  Created by KinomotoMio on 2025/2/9.
//

import SwiftUI

public struct NoteSection: View {
    @Binding var note: String
    @FocusState private var isFocused: Bool
    
    public init(note: Binding<String>) {
        self._note = note
    }
    
    public var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("备注")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextEditor(text: $note)
                    .focused($isFocused)
                    .frame(minHeight: 80)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .overlay(
                        Text("添加备注...")
                            .foregroundColor(.gray)
                            .opacity(note.isEmpty ? 0.6 : 0)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.leading, 16)
                            .padding(.top, 18)
                            .allowsHitTesting(false)
                    )
            }
            .padding(.vertical, 8)
        }
        .headerProminence(.increased)
    }
}

#Preview {
    NoteSection(note: .constant(""))
        .padding()
}
