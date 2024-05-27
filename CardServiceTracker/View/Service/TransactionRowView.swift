//
//  ServiceRowView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: Transaction
    
    var body: some View {
        Text(transaction.identifier)
    }
}

#Preview {
    TransactionRowView(transaction: Transaction(id: "Test Service", cards: []))
}
