//
//  ContentView.swift
//  Banking_2
//
//  Created by Pranav Reddy on 2023-09-29.
//

import SwiftUI

public struct ContentView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var dataManager: DataManager

    public var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab
            DashView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(0)

            // Transactions Tab
            NavigationView {
                MainView()
                    .environmentObject(dataManager)
            }
            .tabItem {
                Image(systemName: "creditcard.fill")
                Text("Transactions")
            }
            .tag(1)

            // Profile Tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(2)
        }
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor.white
        }
        .background(Color(red: 6 / 255, green: 32 / 255, blue: 70 / 255)) // Set the tab bar's background color
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager()) // Provide a DataManager instance for preview
}


