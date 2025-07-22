//
//  RegistrationView.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    
    var body: some View {
        VStack{
            // imag
            Image("icon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.vertical, 32)
            
        // filed
            VStack(spacing: 12) {
                InputView(text: $email, title:  "آدرس ایمیل", placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $email, title:  "آدرس ایمیل", placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $password, title:  "رمز عبور", placeholder: "12345", isSecureField: true)
            }
        .padding(.horizontal)
        .padding(.top, 12)
        }
    }
}

#Preview {
    RegistrationView()
}
