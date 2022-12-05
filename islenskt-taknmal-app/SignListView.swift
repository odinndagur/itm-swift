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
    @State var searchQuery = ""
    @State var filteredSigns: [Sign] = []
    @State var current_collection: SignCollection
    @State private var editMode = EditMode.inactive

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
      }
    }
    
    func delete(at offsets: IndexSet) {
        filteredSigns.remove(atOffsets: offsets)
    }
    
    private var addButton: some View {
        switch editMode {
            case .inactive:
                return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
            default:
                return AnyView(EmptyView())
            }
        }
        
        func onAdd() {
            // To be implemented in the next section
        }

    var body: some View {
        List{
            ForEach(filteredSigns) {sign in
                NavigationLink(destination: SignDetailView(sign:sign, related_signs: relatedSignsById(id: sign.id))) {
                    SignView(sign: sign)
                }
            }
            .onDelete{filteredSigns.remove(atOffsets: $0)}
            .onMove{filteredSigns.move(fromOffsets: $0,toOffset: $1)}
        }
//        .environment(\.editMode, $editMode)
//        .navigationBarItems(leading:EditButton(),trailing: addButton)
                .searchable(text: $searchQuery,placement:.navigationBarDrawer(displayMode:SearchFieldPlacement.NavigationBarDrawerDisplayMode.always))
                .onChange(of: searchQuery) { _ in
                    filterSigns()
                }
                .onAppear(perform: filterSigns)
                .navigationTitle("\(current_collection.name)")
                .padding()
                .toolbar{
                    EditButton()
                }
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
