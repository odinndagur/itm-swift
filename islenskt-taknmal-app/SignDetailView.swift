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

    var body: some View {
        VStack(){
            Text(sign?.phrase ?? "Missing")
            YouTubeView(webViewModel: WebViewModel(id: sign?.youtube_id ?? "")).frame(width: 300,height:400, alignment: .center)
        }
    }

}

struct SignDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SignDetailView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
