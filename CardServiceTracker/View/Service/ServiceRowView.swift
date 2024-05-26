//
//  ServiceRowView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct ServiceRowView: View {
    var service: Service
    
    var body: some View {
        Text(service.identifier)
    }
}

#Preview {
    ServiceRowView(service: Service(id: "Test Service", cards: []))
}
