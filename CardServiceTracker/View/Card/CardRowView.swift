//
//  CardRowView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct CardRowView: View {
    var card: Card
    
    var body: some View {
        Text(card.identifier)
    }
}

#Preview {
    CardRowView(card: Card(id: "Test Card", transactions: []))
}
