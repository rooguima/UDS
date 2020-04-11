//
//  ButtonView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct PrimaryButtonView: View {
    var action: () -> Void
    var label: String
    var disabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .padding(.horizontal)
        }
        .padding(10)
        .foregroundColor(.white)
        .background(disabled ? Color.init("UDSBlueOpaque") : Color.init("UDSBlue"))
        .cornerRadius(25)
        .disabled(disabled)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(action: {}, label: "", disabled: false)
    }
}
