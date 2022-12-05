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

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Íslenskt táknmál")
                    .bold()
                    .padding(.top, 150)
                    .font(.system(size:35))
                List(collections) { c in
                    NavigationLink(c.name, destination:SignListView(current_collection: c))
                }
            }
       }        
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
