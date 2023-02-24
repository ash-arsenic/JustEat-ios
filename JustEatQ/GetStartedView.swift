//
//  GetStartedView.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct GetStartedView: View {
    @State private var loginIsActive = false
    @State private var signUpIsActive = false
    var body: some View {
        NavigationView{
            ZStack{
                Color("PrimaryColor").ignoresSafeArea()
                VStack{
                    HStack{
                        Spacer()
                        Image("GetStartedImage1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150,height: 150)
                            .padding(.trailing, -40)
                    }
                    Spacer()
                    Text("Food For You")
                    Text("With Greatest Ingredients")
                    NavigationLink(destination: LoginView() ,isActive: $loginIsActive ){
                        SecondaryButton(btnTitle: "Log In"){
                            loginIsActive = true
                        }.padding(.horizontal, 20)
                    }
                    NavigationLink(destination: SignupView(), isActive: $signUpIsActive){
                        PrimaryButton(btnTitle: "Sign Up"){
                            signUpIsActive = true
                        }.padding(.horizontal, 20)
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Image("GetStartedImage2").resizable().scaledToFill().frame(width: 150, height: 150)
                    }
                }
            
            }
        }
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
