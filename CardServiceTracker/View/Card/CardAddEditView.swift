//
//  CardAddEditView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/27/24.
//

import SwiftUI
import SwiftData

struct CardAddEditView: View {
    @Bindable var card: Card
    var save: (Card) -> ()
    var delete: (Card) -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $card.identifier)
            }
            Section("Add Service") {
                List {
                    NavigationLink {
                        CardTransactionListView(update: addToCard)
                    } label: {
                        Text("Add Service")
                    }
                    ForEach(card.transactions) { transaction in
                        Text(transaction.identifier)
                    }
                }
            }
            Section {
                Button {
                    save(card)
                    dismiss()
                } label: {
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
    
    func addToCard(_ new: Set<Transaction>) {
        let combinedSet = Set(card.transactions).union(new)
        card.transactions = Array(combinedSet)
    }
}

#Preview {
    let test = Card(id: "Test Card", transactions: [])
    return NavigationStack {
        CardAddEditView(card: test, save: { _ in }, delete: { _ in })
    }
}

struct CardTransactionListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transaction]
    @State private var selection = Set<Transaction>()
    var update: (Set<Transaction>) -> ()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(transactions, id: \.self, selection: $selection) { transaction in
                Text(transaction.identifier)
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
