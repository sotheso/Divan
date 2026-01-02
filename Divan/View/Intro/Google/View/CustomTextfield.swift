//
//  CustomTextfield.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 4/9/22.
//

import SwiftUI
import UIKit

struct CustomTextfield: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke()
        )
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .keyboardType(keyboardType)
        .textContentType(textContentType)
        .autocapitalization(.none)
        .autocorrectionDisabled(true)
    }
}

struct CustomTextfield_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTextfield(text: .constant(""), placeholder: "Email", keyboardType: .emailAddress, textContentType: .emailAddress)
            CustomTextfield(text: .constant(""), placeholder: "Password", isSecure: true, textContentType: .password)
        }
    }
}
