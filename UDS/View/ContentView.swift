//
//  ContentView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 06/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack{
            if(status){
                TabView {
                    GuidelineListView()
                    .tabItem {
                        Image(systemName: "briefcase.fill")
                        Text("Pautas")
                      }
                    
                    ProfileView()
                    .tabItem {
                       Image(systemName: "person.fill")
                       Text("Perfil")
                     }
                }
            }else{
                LoginView()
            }
        }.animation(.interactiveSpring())
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
