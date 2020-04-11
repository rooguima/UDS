//
//  LoginView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 06/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var viewModel = LoginViewModel()
    
    @State var isPresentingNewUserModal = false
    @State var isPresentingForgetPasswordModal = false
    
    @State var value: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 100, alignment: .center)
            
            Spacer()
            
            TextFieldView(placeholder: "Email", value: $viewModel.email)
            TextFieldView(placeholder: "Senha", value: $viewModel.password, secure: true)
            
            PrimaryButtonView(action: {
                self.viewModel.login()
            }, label: "Entrar")
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: .default(Text("Ok")))
                }
            
            Spacer()
            
            VStack(spacing: 10) {
                SecundaryButtonView(action: {
                    self.isPresentingNewUserModal.toggle()
                }, label: "Cadastro")
                .sheet(isPresented: $isPresentingNewUserModal, content: {
                    CreateUserView(isPresented: self.$isPresentingNewUserModal).environment(\.managedObjectContext, self.moc)
                })
                
                SecundaryButtonView(action: {
                    self.isPresentingForgetPasswordModal.toggle()
                }, label: "Recuperar senha")
                .sheet(isPresented: $isPresentingForgetPasswordModal, content: {
                    ForgetPasswordView(isPresented: self.$isPresentingForgetPasswordModal).environment(\.managedObjectContext, self.moc)
                })
            }
        }
        .padding(.horizontal)
        .offset(y: -self.value)
        .onAppear{
            self.viewModel.objectContext = self.moc
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (notification) in
                
                
                if(!self.isPresentingNewUserModal && !self.isPresentingForgetPasswordModal){
                    let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.value = height - 210
                }
                
                
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (notification) in
                
                if(!self.isPresentingNewUserModal && !self.isPresentingForgetPasswordModal){
                    self.value = 0
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
