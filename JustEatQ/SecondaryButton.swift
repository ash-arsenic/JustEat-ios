//
//  SecondaryButton.swift
//  JustEatQ
//
//  Created by Rapipay Macintoshn on 20/02/23.
//

import SwiftUI

struct SecondaryButton: View {
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
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color("TertiaryColor"), lineWidth: 2)
        }
        .foregroundColor(Color("TertiaryColor"))
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(btnTitle: "Button")
    }
}
