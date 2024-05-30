//
//  CardDetailView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct CardDetailView: View {
    var card: Card

    var body: some View {
        Form {
            Section {
                Text(card.identifier)
            }
            Section {
                List {
                    NavigationLink {
                        CardAddEditView(card: card, save: { _ in }, delete: { _ in })
                    } label: {
                        Text("Add New")
                    }
                    ForEach(card.transactions) { transaction in
                        Text(transaction.identifier)
                    }
                }
            }
        }
    }
}

#Preview {
    CardDetailView(card: Card(id: "Test", transactions: []))
}
