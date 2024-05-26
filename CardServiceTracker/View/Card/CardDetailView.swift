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
            Text(card.identifier)
        }
    }
}

#Preview {
    CardDetailView(card: Card(id: "Test", services: []))
}
