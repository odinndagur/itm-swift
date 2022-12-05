//
//  SignDetailView.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 23.11.2022.
//

import Foundation
import SwiftUI
import CoreData


struct SignDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var sign: Sign?
    @State var related_signs: [Sign] = []
    
    var body: some View {
        VStack(){
            Text(sign?.phrase ?? "Missing")
            YouTubeView(webViewModel: WebViewModel(id: sign?.youtube_id ?? "")).frame(width: 300,height:400, alignment: .center)
            List(related_signs){sign in
                NavigationLink(destination: SignDetailView(sign:sign, related_signs: relatedSignsById(id: sign.id))) {
                    SignView(sign: sign)
                }
            }
        }.padding()
    }

}

struct SignDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SignDetailView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
