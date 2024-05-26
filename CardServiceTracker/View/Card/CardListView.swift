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
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {}) {
                        Label("Add Card", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an Card")
        }
    }
}

#Preview {
    CardListView()
        .modelContainer(for: Card.self, inMemory: true)
}
