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
                    HStack {
                        Text("Food For").padding(.trailing, -2)
                        Text("Y").foregroundColor(Color.white)
                        Text("ou").padding(.leading, -10)
                    }.font(.title.weight(.bold))
                    .foregroundColor(Color("TertiaryColor"))
                    
                    HStack {
                        Text("With Greatest Ingredients").fontWeight(.semibold)
                            .kerning(4).foregroundColor(Color.white)
                    }
                    
                    NavigationLink(destination: LoginView() ,isActive: $loginIsActive ){
                        SecondaryButton(btnTitle: "Log In"){
                            loginIsActive = true
                        }.padding().padding(.horizontal, 12)
                    }
                    NavigationLink(destination: SignupView(), isActive: $signUpIsActive){
                        PrimaryButton(btnTitle: "Sign Up"){
                            signUpIsActive = true
                        }.padding(.horizontal, 12).padding(.horizontal)
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Image("GetStartedImage2").resizable().scaledToFill().frame(width: 200, height: 180)
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
