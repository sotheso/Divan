//
//  LoginView.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack{
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
                    
                    InputView(text: $password, title:  "رمز عبور", placeholder: "12345", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    print("log user in ...")
                    
                } label: {
                    HStack {
                        Text("وارد شوید")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(12)
                .padding(.top, 24)
                
                
                
                // sign in
                Spacer()
                
                // sing up
                
                NavigationLink{
                    
                } label: {
                    HStack(spacing: 3){
                        Text("ثبت نام کنید")
                            .fontWeight(.bold)
                        Text("حساب کاربری ندارید؟")
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
