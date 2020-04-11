//
//  GuidelinesView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 06/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct GuidelineListView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var closedFilter: Int = 0
    @State var isPresentingAddModal = false
    
    @ObservedObject var viewModel = GuidelineListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Picker("Status", selection: $viewModel.closedFilter) {
                        ForEach(0..<viewModel.status.count) {
                            Text(self.viewModel.status[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    ForEach(viewModel.guidelines, id: \.id){guideline in
                        GuidelineView(guideline: guideline)
                    }.padding(.vertical, 5)
                    
                    if(viewModel.guidelines.count == 0){
                        Text("Nenhuma pauta " + (viewModel.closedFilter == 0 ? "aberta" : "finalizada"))
                            .font(.title)
                            .padding()
                    }
                    
                }
            }
            .navigationBarTitle("Pautas")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresentingAddModal.toggle()
                }) {
                    Text("Incluir Pauta")
                }
            )
            .sheet(isPresented: $isPresentingAddModal, onDismiss: {
                self.viewModel.load()
            }, content: {
                CreateGuidelineView(isPresented: self.$isPresentingAddModal).environment(\.managedObjectContext, self.moc)
            })
        }.onAppear{
            self.viewModel.objectContext = self.moc
            self.viewModel.closedFilter = self.closedFilter
            self.viewModel.load()
            
            
        }
    }
}

struct GuidelinesView_Previews: PreviewProvider {
    static var previews: some View {
        GuidelineListView()
    }
}
