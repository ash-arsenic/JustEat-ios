//
//  JEDateField.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct JEDateField: View {
    @Binding var ddTF: String
    @Binding var mmTF: String
    @Binding var yyTF: String
    @Binding var showError: Bool
    
    @FocusState private var ddFocus
    @FocusState private var mmFocus
    @FocusState private var yyFocus
//    @FocusState var dateFocus
    
    @State var borderColor = Color.gray
    
    init(ddTF: Binding<String>, mmTF: Binding<String>, yyTF: Binding<String>, showError: Binding<Bool>) {
        self._ddTF = ddTF
        self._mmTF = mmTF
        self._yyTF = yyTF
        self._showError = showError
    }
    
    var body: some View {
        ZStack {
            HStack {
                TextField("DD", text: $ddTF)
                    .focused($ddFocus)
                    .onChange(of: ddTF, perform: { data in
                        showError = false
                        borderColor = showError ? Color.red : Color("TertiaryColor")
                        if(data.count >= 2) {
                            mmFocus.toggle()
                        }
                        if data.count > 2 {
                            ddTF.popLast()
                        }
                    })
                    .onSubmit {
                        mmFocus.toggle()
                    }
                    .frame(width: 30)
                Text("/")
                TextField("MM", text: $mmTF)
                    .focused($mmFocus)
                    .onChange(of: mmTF, perform: { data in
                        showError = false
                        borderColor = showError ? Color.red : Color("TertiaryColor")
                        if(data.count >= 2) {
                            yyFocus.toggle()
                        }
                        if data.count > 2 {
                            ddTF.popLast()
                        }
                        if let char = data.cString(using: String.Encoding.utf8) {
                            let isBackSpace = strcmp(char, "\\b")
                            if (isBackSpace == -92) {
                                ddFocus.toggle()
                            }
                        }
                    })
                    .onSubmit {
                        yyFocus.toggle()
                    }
                    .frame(width: 30)
                Text("/")
                TextField("YYYY", text: $yyTF)
                    .focused($yyFocus)
                    .onChange(of: yyTF, perform: { data in
                        showError = false
                        borderColor = showError ? Color.red : Color("TertiaryColor")
                        if data.count >= 4 {
                            yyTF = String(yyTF.prefix(4))
                        }
                        if let char = data.cString(using: String.Encoding.utf8) {
                            let isBackSpace = strcmp(char, "\\b")
                            if (isBackSpace == -92) {
                                mmFocus.toggle()
                            }
                        }
                    })
                    .frame(width: 50)
                
                Spacer()
            }
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(borderColor, lineWidth: 2)
            }
            
            if ddFocus || mmFocus || yyFocus {
                HStack {
                    Text("Date of Birth")
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
            
        }.onTapGesture {
            ddFocus.toggle()
        }
    }
}

struct JEDateField_Previews: PreviewProvider {
    static var previews: some View {
        JEDateField(ddTF: .constant(""), mmTF: .constant(""), yyTF: .constant(""), showError: .constant(false))
    }
}
