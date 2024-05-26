//
//  Item.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
