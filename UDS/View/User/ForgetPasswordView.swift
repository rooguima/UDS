//
//  ForgetPasswordView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 07/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct ForgetPasswordView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isPresented: Bool
    @ObservedObject var viewModel = ForgetPasswordViewModel()
    
    @State var value: CGFloat = 0
    @State var canClose = false
    
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
            
            TextFieldView(placeholder: "Email", value: $viewModel.email)
            
            PrimaryButtonView(action: {
                self.canClose = self.viewModel.recoverPassword()
            }, label: "Recuperar senha")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(self.viewModel.alertTitle), message: Text(self.viewModel.alertMessage), dismissButton: Alert.Button.cancel(Text("Ok"), action: {
                        if(self.canClose){
                            self.isPresented = false
                        }
                    })
                )
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
                self.value = height - 180
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (notification) in
                
                self.value = 0
            }
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView(isPresented: .constant(true))
    }
}
