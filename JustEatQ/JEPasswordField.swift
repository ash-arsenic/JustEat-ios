//
//  JEPasswordField.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct JEPasswordField: View {
    var title: String
    @Binding var text: String
    @Binding var showError: Bool
    @State var isSecured: Bool = true
    
    @FocusState var securedFocused
    @FocusState var textFocused
    
    init(_ title: String, text: Binding<String>, showError: Binding<Bool>) {
        self.title = title
        self._text = text
        self._showError = showError
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    JESecuredField(title, text: $text, showError: $showError)
                        .focused($securedFocused)
                } else {
                    JETextField(title, text: $text, showError: $showError)
                        .focused($textFocused)
                }
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(Color.gray)
            }.padding()
        }
    }
}

struct JEPasswordField_Previews: PreviewProvider {
    static var previews: some View {
        JEPasswordField("Password", text: .constant(""), showError: .constant(false))
    }
}
