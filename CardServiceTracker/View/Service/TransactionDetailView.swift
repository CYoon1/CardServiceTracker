//
//  ServiceDetailView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct TransactionDetailView: View {
    var transaction: Transaction
    var body: some View {
        Form {
            Section {
                Text(transaction.identifier)
            }
            Section("Cards") {
                List {
                    Button("Add New") {
                        
                    }
                    ForEach(transaction.cards) { card in
                        Text(card.identifier)
                    }
                }
            }
        }
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction(id: "Test Service", cards: []))
}
