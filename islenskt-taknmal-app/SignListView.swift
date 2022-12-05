//
//  SignListView.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 4.12.2022.
//


import SwiftUI
import CoreData
import Foundation

struct SignListView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//    var user_collection: [Int] = userDefaults.object(forKey: "user_collection") as? [Int] ?? [1,2,3,4]
    @State var searchQuery = ""
    @State var filteredSigns = signList
    @State var current_collection: SignCollection
//    let user_signs: [Sign]
//    init(){
//        user_signs = Array(Set(user_collection)).map { id in
//            return signById(id: id)
//        }
//    }
    
    func filterSigns() {
      if searchQuery.isEmpty {
        // 1
          filteredSigns = current_collection.signs
      } else {
        // 2
        filteredSigns = current_collection.signs.filter {
          $0.phrase
            .localizedCaseInsensitiveContains(searchQuery)
        }
//          filteredSigns = try! db
//              .prepare(signs
//                .filter(phrase.like("%" + searchQuery + "%"))
//              ).map(
//                { row in
//                    return Sign(
//                        id: row[sign_id],
//                        phrase: row[phrase],
//                        youtube_id: row[youtube_id],
//                        youtube_link: row[youtube_link]
//                    )
//                })
      }
    }

    var body: some View {
            NavigationView {
//                VStack{
//                List(user_collection, id: \.self) {id in
//                    SignView(sign: signById(id: id))
//                }
                List(filteredSigns) {sign in
                    NavigationLink(destination: SignDetailView(sign:sign)) {
                        SignView(sign: sign)
                    }
                }
                .searchable(text: $searchQuery,placement:.navigationBarDrawer(displayMode:SearchFieldPlacement.NavigationBarDrawerDisplayMode.always))
                .onChange(of: searchQuery) { _ in
                    filterSigns()
                }
                .navigationTitle("Tákn")
            }
//            }
            

        }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct SignListView_Previews: PreviewProvider {
    static var previews: some View {
        SignListView(searchQuery: "", current_collection: SignCollection(name: "Lol", signs: [signById(id: 5)])).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
