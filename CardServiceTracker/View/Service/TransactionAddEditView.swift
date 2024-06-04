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
                TextField("Name", text: $transaction.identifier)
            }
            Section("Cards") {
                if showAddListOpen {
                    TransactionCardListView(update: updateTransaction, showAddListOpen: $showAddListOpen, currentlySelected: transaction.cards)
                } else {
                    List {
                        Button {
                            showAddListOpen.toggle()
                        } label: {
                            Text("Edit")
                        }
                        if transaction.cards.isEmpty {
                            Text("No Cards on Record")
                        } else {
                            ForEach(transaction.cards) { card in
                                Text(card.identifier)
                            }
                        }
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
    
    func updateTransaction(_ updated: Set<Card>) {
        transaction.cards = Array(updated)
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
    @Binding var showAddListOpen: Bool
    
    var currentlySelected : [Card] = []
    
    var body: some View {
        List {
            Button {
                update(selection)
                //                        dismiss()
                showAddListOpen = false
            } label: {
                Text("Confirm")
            }
            ForEach(cards) { card in
                TransactionCardListRowView(card: card, isSelected: selection.contains(card))
                    .onTapGesture {
                        if selection.contains(card) {
                            selection.remove(card)
                        } else {
                            selection.insert(card)
                        }
                    }
            }
        }
        .onAppear(perform: {
            selection = Set(currentlySelected)
        })
    }
}

struct TransactionCardListRowView: View {
    var card: Card
    var isSelected = false
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle" : "circle")
            Text(card.identifier)
        }
    }
}
