//
//  TransactionAddEditView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/27/24.
//

import SwiftUI

struct TransactionAddEditView: View {
    @Bindable var transaction: Transaction
    var save: (Transaction) -> ()
    var delete: (Transaction) -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $transaction.identifier)
            }
            Section("Cards") {
                List {
                    Text("List of Cards")
                    ForEach(transaction.cards) { card in
                        Text(card.identifier)
                    }
                }
            }
            Section {
                Button(action: {
                    save(transaction)
                    dismiss()
                }) {
                    Text("Save")
                }
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }

            }
        }
    }
}

#Preview {
    let test = Transaction(id: "Test Transaction", cards: [])
    return NavigationStack {
        TransactionAddEditView(transaction: test, save: { _ in }, delete: { _ in })
    }
}
