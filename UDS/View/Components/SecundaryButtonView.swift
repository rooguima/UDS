//
//  SecundaryButtonView.swift
//  UDS
//
//  Created by Rodrigo Guimarães on 10/04/20.
//  Copyright © 2020 Rodrigo Guimarães. All rights reserved.
//

import SwiftUI

struct SecundaryButtonView: View {
    var action: () -> Void
    var label: String
       
    var body: some View {
        Button(action: action) {
            Text(label)
        }
        .padding(10)
        .foregroundColor(Color.init("UDSBlue"))
    }
}

struct SecundaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SecundaryButtonView(action: {}, label: "")
    }
}
