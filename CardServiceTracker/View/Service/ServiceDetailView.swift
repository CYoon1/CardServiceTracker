//
//  ServiceDetailView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct ServiceDetailView: View {
    var service: Service
    var body: some View {
        Form {
            Text(service.identifier)
            List {
                ForEach(service.cards) { card in
                    Text(card.identifier)
                }
            }
        }
    }
}

#Preview {
    ServiceDetailView(service: Service(id: "Test Service", cards: []))
}
