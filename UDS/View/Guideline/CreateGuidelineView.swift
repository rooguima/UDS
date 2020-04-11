//
//  CreateGuidelineView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct CreateGuidelineView: View {
    @Binding var isPresented: Bool
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel = CreateGuidelineViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State var value: CGFloat = 0
    
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 40, height: 7)
                .cornerRadius(5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding()
                .offset(y: self.value)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Titulo")
                        .font(.headline)
                    TextFieldView(placeholder: "Titulo", value: $viewModel.title)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Breve Descrição")
                        .font(.headline)
                    TextFieldView(placeholder: "Breve Descrição", value: $viewModel.briefDescription)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Detalhes")
                        .font(.headline)
                    TextFieldView(placeholder: "Detalhes", value: $viewModel.fullDescription)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Autor")
                        .font(.headline)
                    Text((profileViewModel.user != nil) ? profileViewModel.user!.name : "")
                }
            }.padding(.vertical, 10)
            
            PrimaryButtonView(action: {
                self.isPresented = false
                self.viewModel.user = self.profileViewModel.user!
                self.viewModel.save()
            }, label: "Finalizar", disabled: !self.viewModel.enableButton())
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .offset(y: -self.value)
        .onAppear{
            self.viewModel.objectContext = self.moc
            self.profileViewModel.objectContext = self.moc
            self.profileViewModel.load()
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (notification) in
                
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.value = height - 180
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (notification) in
                
                self.value = 0
            }
        }
    }
}

struct CreateGuidelineView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGuidelineView(isPresented: .constant(true))
    }
}
