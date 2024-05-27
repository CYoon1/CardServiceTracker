//
//  CardAddEditView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/27/24.
//

import SwiftUI

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
            Section {
                List {
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
}

#Preview {
    let test = Card(id: "Test Card", transactions: [])
    return NavigationStack {
        CardAddEditView(card: test, save: { _ in }, delete: { _ in })
    }
}
