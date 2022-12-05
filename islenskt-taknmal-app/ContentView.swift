//
//  ContentView.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 22.11.2022.
//

import SwiftUI
import CoreData
import Foundation

let userDefaults = UserDefaults.standard

struct SignCollection: Identifiable {
    let id = UUID()
    let name: String
    let signs: [Sign]
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let collections: [SignCollection] = [SignCollection(name: "Öll tákn", signs: signList),SignCollection(name: "Skóli",signs: [signById(id:5),signById(id:2),signById(id: 50),signById(id:20),signById(id:51),signById(id:22)]),SignCollection(name: "LRL",signs: [signById(id:500),signById(id:201),signById(id:510),signById(id:290),signById(id: 522),signById(id:230)])]
    
    var body: some View {
        NavigationView {
            List(collections) { c in
                NavigationLink(c.name, destination:SignListView(current_collection: c))
//                Text(c.name)
            }
       }
//            SignListView()
        
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        }
//    }
}
