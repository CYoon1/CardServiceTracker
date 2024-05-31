//
//  ServiceListView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var transactions: [Transaction]
    @State private var showAddView = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(transactions) { transaction in
                    NavigationLink {
                        TransactionAddEditView(transaction: transaction, save: save, delete: { _ in })
                    } label: {
                        TransactionRowView(transaction: transaction)
                    }
                }
                .onDelete(perform: deleteTransactions)
            }
            .navigationDestination(isPresented: $showAddView) {
                TransactionAddEditView(transaction: Transaction(id: "New", cards: []), save: add, delete: { _ in })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        showAddView = true
                    } label: {
                            Label("Add Card", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a Service")
        }
    }
}

extension TransactionListView {
    private func save(_ transaction: Transaction) {
        withAnimation {
            try? self.modelContext.save()
        }
    }
    private func add(_ transaction: Transaction) {
        withAnimation {
            modelContext.insert(transaction)
        }
    }
    private func deleteTransactions(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(transactions[index])
            }
        }
    }
}

#Preview {
    TransactionListView()
        .modelContainer(for: Transaction.self, inMemory: true)
}
