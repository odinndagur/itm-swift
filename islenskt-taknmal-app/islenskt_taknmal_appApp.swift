//
//  islenskt_taknmal_appApp.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 22.11.2022.
//

import SwiftUI

@main
struct islenskt_taknmal_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
