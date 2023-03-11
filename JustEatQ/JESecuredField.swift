//
//  JESecuredField.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct JESecuredField: View {
    private var title: String
    @Binding private var text: String
    @Binding var showError: Bool
    @FocusState private var showLabel
    
    @State private var borderColor = Color(.gray)
    
    init(_ title: String, text: Binding<String>, showError: Binding<Bool>) {
        self.title = title
        self._text = text
        self._showError = showError
    }
    
    var body: some View {
        ZStack {
            SecureField(title, text: $text)
                .onChange(of: text, perform: { data in
                    showError = false
                    borderColor = showError ? Color.red : Color("TertiaryColor")
                })
                .onTapGesture {
//                    borderColor = showError ? Color.red : Color.blue
                }
                .onSubmit {
//                    borderColor = showError ? Color.red : Color.gray
                }
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
                        .foregroundColor(Color("TertiaryColor"))
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

struct JESecuredField_Previews: PreviewProvider {
    static var previews: some View {
        JESecuredField("Password", text: .constant(""), showError: .constant(false))
    }
}
