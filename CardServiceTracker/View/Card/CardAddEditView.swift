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
    @State var showAddListOpen : Bool = false
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $card.identifier)
            }
            Section("Add Service") {
                if showAddListOpen {
                    CardTransactionListView(update: addToCard, showAddListOpen: $showAddListOpen, currentlySelected: card.transactions)
                } else {
                    List {
                        HStack {
                            Text(".").opacity(0.001)
                            Spacer()
                            Button {
                                showAddListOpen.toggle()
                            } label: {
                                Text("Edit List")
                                    .frame(maxWidth: .infinity)
                            }
                            Spacer()
                        }
                        if card.transactions.isEmpty {
                            Text("No Services on Record")
                        } else {
                            ForEach(card.transactions) { transaction in
                                Text(transaction.identifier)
                            }
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                        return 0
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
        .navigationTitle("Card")
    }
    
    func addToCard(_ updated: Set<Transaction>) {
        card.transactions = Array(updated)
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
    @Binding var showAddListOpen: Bool
    
    var currentlySelected : [Transaction] = []
    
    var body: some View {
        List {
            HStack {
                Button {
                    update(selection)
                    showAddListOpen = false
                } label: {
                    Text("Confirm")
                }
                .buttonStyle(BorderedButtonStyle())
                Spacer()
                Button {
                    showAddListOpen = false
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(BorderedButtonStyle())
                .tint(.red)
            }
            ForEach(transactions) { transaction in
                CardTransactionListRowView(transaction: transaction, isSelected: selection.contains(transaction))
                    .onTapGesture {
                        if selection.contains(transaction) {
                            selection.remove(transaction)
                        } else {
                            selection.insert(transaction)
                        }
                    }
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return 0
        }
        .onAppear {
            selection = Set(currentlySelected)
        }
    }
    
}

struct CardTransactionListRowView: View {
    var transaction : Transaction
    var isSelected = false
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle" : "circle")
            Text(transaction.identifier)
        }
    }
}
