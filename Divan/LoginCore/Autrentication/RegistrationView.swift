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
    @Environment(\.dismiss) var dismiss
    
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
                
                InputView(text: $fullName , title:  "اسم و فامیل", placeholder: "Mohammad Karimi")
                
                InputView(text: $email, title:  "رمز عبور", placeholder: "12345")
                    .autocapitalization(.none)
                
                
                InputView(text: $confirmpassword, title:  "تکرار رمز عبور", placeholder: "12345", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            Button {
                print("log user in ...")
                
            } label: {
                HStack {
                    Text("ثبت نام")
                        .fontWeight(.semibold)
                    
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(12)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("وارد شوید")
                        .fontWeight(.bold)
                    Text("قبلا ثبت نام کردین؟")
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    RegistrationView()
}
