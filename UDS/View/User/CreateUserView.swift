//
//  RegisterUserView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 07/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI
import CryptoKit

struct CreateUserView: View {
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = CreateUserViewModel()
    @Binding var isPresented: Bool
    
    @State var value: CGFloat = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 7)
                .cornerRadius(5)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding()
                .offset(y: self.value)
            
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100, alignment: .center)
            
            Spacer()
            
            TextFieldView(placeholder: "Nome", value: $viewModel.name)
            TextFieldView(placeholder: "Email", value: $viewModel.email)
            TextFieldView(placeholder: "Senha", value: $viewModel.password, secure: true)
            
            PrimaryButtonView(action: {
                if(self.viewModel.create()){
                    self.isPresented = false
                }
            }, label: "Criar conta")
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("Ok")))
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .offset(y: -self.value)
        .onAppear{
            self.viewModel.objectContext = self.moc
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (notification) in
                
                let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.value = height - 150
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (notification) in
                
                self.value = 0
            }
        }
    }
}

struct RegisterUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(isPresented: .constant(true))
    }
}
