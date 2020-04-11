//
//  GuidelineView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct GuidelineView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var isExpanded: Bool = false
    @ObservedObject var viewModel = GuidelineViewModel()
    
    var guideline: Guideline
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(guideline.title)
                .font(.title)
                .bold()
            
            Text(guideline.briefDescription)
                .font(.body)
            
            if(isExpanded){
                Text(guideline.fullDescription)
                .font(.body)
                
                Text(guideline.author.name)
                .font(.footnote)
                
                PrimaryButtonView(action: {
                    self.viewModel.objectContext = self.moc
                    self.viewModel.guideline = self.guideline
                    self.viewModel.close()
                }, label: guideline.closed ? "Reabrir" : "Finalizar")
            }
        }
        .padding()
            .frame(minWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
        .background(Color.init("CardBackground"))
        .cornerRadius(24)
        .shadow(radius: 3)
        .onTapGesture {
            if(!self.isExpanded){
                NotificationCenter.default.post(name: NSNotification.Name("closeGuideline"), object: nil)
            }
            self.isExpanded.toggle()
        }.onAppear{
            NotificationCenter.default.addObserver(forName: NSNotification.Name("closeGuideline"), object: nil, queue: .main) { (_) in
                self.isExpanded = false
            }
        }
    }
}

struct GuidelineView_Previews: PreviewProvider {
    static var previews: some View {
        GuidelineView(guideline: Guideline())
    }
}
