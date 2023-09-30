//
//  Banking_2App.swift
//  Banking_2
//
//  Created by Pranav Reddy on 2023-09-27.
//

import SwiftUI
import Firebase


@main
struct Banking_2App: App {
    @StateObject var dataManager = DataManager()
    @StateObject var appData = AppData() // Create an instance of AppData

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(dataManager)
                .environmentObject(appData) // Inject appData into the environment
        }
    }
}
