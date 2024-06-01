//
//  TransactionAddEditView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/27/24.
//

import SwiftUI
import SwiftData

struct TransactionAddEditView: View {
    @Bindable var transaction: Transaction
    var save: (Transaction) -> ()
    var delete: (Transaction) -> ()
    @Environment(\.dismiss) var dismiss
    @State var showAddListOpen : Bool = false
    
    var body: some View {
        Form {
            Section {
                NavigationLink {
                    TransactionCardListView(update: addToTransaction)
                } label: {
                    Text("Add Card")
                }
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
    
    func addToTransaction(_ new: Set<Card>) {
        let combinedSet = Set(transaction.cards).union(new)
        transaction.cards = Array(combinedSet)
    }
}

#Preview {
    let test = Transaction(id: "Test Transaction", cards: [])
    return NavigationStack {
        TransactionAddEditView(transaction: test, save: { _ in }, delete: { _ in })
    }
}

struct TransactionCardListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cards: [Card]
    @State private var selection = Set<Card>()
    var update: (Set<Card>) -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(cards, id: \.self, selection: $selection) { card in
                Text(card.identifier)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        update(selection)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
}
