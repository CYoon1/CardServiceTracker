//
//  CardListView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cards: [Card]
    @State private var showAddView = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(cards) { card in
                    NavigationLink {
                        CardDetailView(card: card)
                    } label: {
                        CardRowView(card: card)
                    }
                }
                .onDelete(perform: deleteCards)
            }
            .navigationDestination(isPresented: $showAddView, destination: {
                CardAddEditView(card: Card(id: "New", transactions: []), save: add, delete: { _ in })
            })
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
            Text("Select an Card")
        }
    }
}

extension CardListView {
    private func save(_ card: Card) {
        withAnimation {
            try? self.modelContext.save()
        }
    }
    private func add(_ card: Card) {
        withAnimation {
            modelContext.insert(card)
        }
    }
    
    private func deleteCards(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(cards[index])
            }
        }
    }
    
}

#Preview {
    CardListView()
        .modelContainer(for: Card.self, inMemory: true)
}
