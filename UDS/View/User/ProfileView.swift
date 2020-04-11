//
//  ProfileView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 07/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            List{
                Section(header: Text("Nome")) {
                    Text((viewModel.user != nil) ? viewModel.user!.name : "")
                }
                
                Section(header: Text("Email")) {
                    Text((viewModel.user != nil) ? viewModel.user!.email : "")
                }
                
                Button(action: {
                    self.viewModel.logout()
                }) {
                    Text("Sair")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Perfil")
        }
        .onAppear{
            self.viewModel.objectContext = self.moc
            self.viewModel.load()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
