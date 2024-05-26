//
//  Service.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import Foundation
import SwiftData

enum CardUse {
    case subscription
    case payment
    case notstated
}

class StoredCard {
    var id = UUID()
    var dateAdded: Date = Date()
    var card: Card
    var usage: [CardUse]
    
    init(card: Card, usage: [CardUse]) {
        self.card = card
        self.usage = usage
    }
}

@Model
final class Service {
    var identifier: String
    var cards: [Card]
    
    init(id: String, cards: [Card]) {
        self.identifier = id
        self.cards = cards
    }
}
