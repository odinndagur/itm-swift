//
//  itmApp.swift
//  itm
//
//  Created by Óðinn Dagur Bjarnason on 22.11.2022.
//

import SwiftUI

@main
struct itmApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
