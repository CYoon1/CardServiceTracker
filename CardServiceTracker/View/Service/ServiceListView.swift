//
//  ServiceListView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI
import SwiftData

struct ServiceListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var services: [Service]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(services) { service in
                    NavigationLink {
                        ServiceDetailView(service: service)
                    } label: {
                        ServiceRowView(service: service)
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {}) {
                        Label("Add Service", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a Service")
        }
    }
}

#Preview {
    ServiceListView()
        .modelContainer(for: Service.self, inMemory: true)
}
