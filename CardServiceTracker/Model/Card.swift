//
//  Card.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import Foundation
import SwiftData

@Model
final class Card {
    var identifier: String
    @Relationship(inverse: \Transaction.cards) var transactions: [Transaction]
    
    init(id: String, transactions: [Transaction]) {
        self.identifier = id
        self.transactions = transactions
    }
}
