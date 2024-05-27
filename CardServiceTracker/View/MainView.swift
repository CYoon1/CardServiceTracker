//
//  MainView.swift
//  CardServiceTracker
//
//  Created by Christopher Yoon on 5/26/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            TabView {
                CardListView()
                    .tabItem {
                        Label("Card", systemImage: "creditcard")
                    }
                TransactionListView()
                    .tabItem {
                        Label("Service", systemImage: "menucard")
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
