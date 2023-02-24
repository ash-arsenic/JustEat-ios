//
//  PrimaryButton.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct PrimaryButton: View {
    var btnTitle: String
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: action ?? {
            print("No Action")
        },label: {
            Spacer()
            Text(btnTitle)
            Spacer()
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("TertiaryColor"))
        .cornerRadius(15)
        .foregroundColor(.white)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(btnTitle: "Button")
    }
}
