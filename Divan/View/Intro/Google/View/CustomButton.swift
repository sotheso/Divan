//
//  CustomButton.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 4/9/22.
//

import SwiftUI

struct CustomButton: View {
    var title: String = "Login"
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding()
        .background(.black)
        .cornerRadius(12)
        .padding()
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
