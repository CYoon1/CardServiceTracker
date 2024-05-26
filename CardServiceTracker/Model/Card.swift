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
    @Relationship(inverse: \Service.cards) var services: [Service]
    
    init(id: String, services: [Service]) {
        self.identifier = id
        self.services = services
    }
}
