//
//  LoginView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct LoginView: View {
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    	
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var emailShowError = false
    @State private var emailTF = ""
    @FocusState private var emailFocused
    
    @State private var pswdShowError = false
    @State private var pswdTF = ""
    @FocusState private var pswdFocused
    
    @State private var showAlert = false
    @State private var showAlertMSG = "Logged In Successfully"
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            VStack {
                Image("RegisterBanner")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .padding(.vertical, 40)
                    .cornerRadius(20)
                
                JETextField("Email", text: $emailTF, showError: $emailShowError)
                    .focused($emailFocused)
                    .onSubmit {
                        emailShowError = !validateEmail(email: emailTF)
                        pswdFocused.toggle()
                    }.padding(.vertical, 4)
                
                JEPasswordField("Password", text: $pswdTF, showError: $pswdShowError)
                    .focused($pswdFocused)
                    .onSubmit {
                        pswdShowError = !validatePswd(pswd: pswdTF)
                        pswdFocused.toggle()
                    }.padding(.vertical, 4)
                
                PrimaryButton(btnTitle: "LogIn") {
                    if authenticateUser(email: emailTF, pswd: pswdTF) {
                        userSettings.signIn()
                        UserDefaults.standard.set(true, forKey: "loggedIn")
                    } else {
                        showAlertMSG = "Invalid Credentials"
                        showAlert = true
                    }
                }.alert(showAlertMSG, isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                }.padding(.vertical)
            }.padding(32)
                .onAppear() {
                    print(users.count)
                }
        }.navigationBarTitle("Sign In", displayMode: .inline)
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
    
    func authenticateUser(email: String, pswd: String) -> Bool {
        for user in users {
            if email == user.email! && pswd == user.password!{
                UserDefaults.standard.set(user.name!, forKey: "userName")
                UserDefaults.standard.set(user.email!, forKey: "userEmail")
                UserDefaults.standard.set(user.dob!, forKey: "userDob")
                return true
            }
        }
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
