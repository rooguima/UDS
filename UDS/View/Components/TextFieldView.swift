//
//  InputView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    @Binding var value: String
    var secure: Bool = false
    
    var body: some View {
        VStack{
            if(secure){
                SecureField(placeholder, text: $value)
                    .padding(10)
                    .background(Color.init("TextFieldBackground"))
                    .cornerRadius(25)
                    .autocapitalization(.none)
            }else{
                TextField(placeholder, text: $value)
                    .padding(10)
                    .background(Color.init("TextFieldBackground"))
                    .cornerRadius(25)
                    .autocapitalization(.none)
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "", value: .constant(""))
    }
}
