//
//  SignView.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 23.11.2022.
//

import Foundation
import SwiftUI
import CoreData


struct SignView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var sign: Sign?

    var body: some View {
        VStack {
            HStack{
                Text(sign?.phrase ?? "Missing").frame(maxWidth: .infinity,alignment:.leading)
                Text("+").frame(maxWidth: .infinity,alignment:.trailing)
            }

        }
    }

}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
