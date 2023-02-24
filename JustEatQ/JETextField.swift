//
//  JETextField.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct JETextField: View {
    var title: String
    @Binding var showError: Bool
    @Binding var text: String
    
    @State private var borderColor = Color(.gray)
    @FocusState private var showLabel
    
    init(_ title: String, text: Binding<String>, showError: Binding<Bool>) {
        self.title = title
        self._showError = showError
        self._text = text
    }
    
    var body: some View {
        ZStack {
            TextField(title, text: $text)
                .onChange(of: text, perform: { data in
                    showError = false
                    borderColor = showError ? Color(.red) : Color("TertiaryColor")
                })
                .focused($showLabel)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(borderColor, lineWidth: 2)
                }
            
            if showLabel {
                HStack {
                    Text(title)
                        .padding(.horizontal, 5)
                        .background(Color.white)
                    Spacer()
                }.padding(.bottom, 50)
                    .padding(.leading, 20)
                    .onAppear() {
                        borderColor = showError ? Color.red : Color("TertiaryColor")
                    }
                    .onDisappear() {
                        borderColor = showError ? Color.red : Color.gray
                    }
            }
        }
    }
}

struct JETextField_Previews: PreviewProvider {
    static var previews: some View {
        JETextField("Text Field", text: .constant(""), showError: .constant(false))
    }
}
