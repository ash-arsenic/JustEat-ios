//
//  SignupView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct SignupView: View {
    
    @State private var emailShowError = false
    @State private var emailTF = ""
    @FocusState private var emailFocused
    
    @State private var nameShowError = false
    @State private var nameTF = ""
    @FocusState private var nameFocused
    
    @State private var dateShowError = false
    @State private var ddTF = ""
    @State private var mmTF = ""
    @State private var yyTF = ""
    @FocusState private var dateFocused
    
    @State private var pswdShowError = false
    @State private var pswdTF = ""
    @FocusState private var pswdFocused
    
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            VStack {
                Image("RegisterBanner")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .padding(.vertical, 20)
                    .cornerRadius(20)
                    .padding()
                
                JETextField("Email", text: $emailTF, showError: $emailShowError)
                    .focused($emailFocused)
                    .onSubmit {
                        emailShowError = !validateEmail(email: emailTF)
                        nameFocused.toggle()
                    }
                
                JETextField("Name", text: $nameTF, showError: $nameShowError)
                    .focused($nameFocused)
                    .onSubmit {
                        nameShowError = !validateName(name: nameTF)
                        dateFocused.toggle()
                    }
                
                JEDateField(ddTF: $ddTF, mmTF: $mmTF, yyTF: $yyTF, showError: $dateShowError)
                    .focused($dateFocused)
                    .onSubmit {
                        dateShowError = !validDate(day: ddTF, month: mmTF, year: yyTF)
                        pswdFocused.toggle()
                    }
                
                JEPasswordField("Password", text: $pswdTF, showError: $pswdShowError)
                    .focused($pswdFocused)
                    .onSubmit {
                        pswdShowError = !validatePswd(pswd: pswdTF)
                    }
                
                PrimaryButton(btnTitle: "SignUp") {
                    if !validateName(name: nameTF) {
                        nameShowError = true
                        //                    nameFocused.toggle()
                    }
                    if !validateEmail(email: emailTF) {
                        emailShowError = true
                        //                    emailFocused.toggle()
                    }
                    if !validDate(day: ddTF, month: mmTF, year: yyTF) {
                        dateShowError = true
                        //                    dateFocused.toggle()
                    }
                    if !validatePswd(pswd: pswdTF) {
                        pswdShowError = true
                        //                    pswdFocused.toggle()
                    }
                    
                    if validateName(name: nameTF) && validateEmail(email: emailTF) && validDate(day: ddTF, month: mmTF, year: yyTF) && validatePswd(pswd: pswdTF) {
                        UserDefaults.standard.set(emailTF, forKey: "userEmail")
                        UserDefaults.standard.set(pswdTF, forKey: "userPswd")
                        showAlert = true
                    }
                }.alert("Signed Up Successfully", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        self.presentation.wrappedValue.dismiss()
                    }
                }.padding()
            }.padding(32)
        }
    }
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validatePswd(pswd: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: pswd)
    }
    
    func validateName(name: String) -> Bool {
        if name.count < 3 {
            return false
        }
        return true
    }
    
    func validDate(day: String, month: String, year: String) -> Bool {
        guard let day = Int(day) else {return false}
        guard let month = Int(month) else {return false}
        guard let year = Int(year) else {return false}
        var m = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if year >= 2023 {
            return false
        }
        if month < 1 || month > 12 {
            return false
        }
        if year % 4 == 0 {
            if !(year % 100 == 0 && year % 400 != 0) {
                m[1] = 29
            }
        }
        if day < 1 || day > m[month-1] {
            return false
        }
        
        return true
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
