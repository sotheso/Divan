//
//  ContentView.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 12/5/22.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase

struct LoginScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var isShowingSignUp: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                LoginHeader()
                    .padding(.bottom)
                
                CustomTextfield(text: $email, placeholder: "Email", keyboardType: .emailAddress, textContentType: .emailAddress)
                
                CustomTextfield(text: $password, placeholder: "Password", isSecure: true, textContentType: .password)
                
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password?")
                    }
                }
                .padding(.trailing, 24)
                
                CustomButton(title: "Login") {
                    Task { await loginWithEmail() }
                }
                
                
                Text("or")
                    .padding()
                
                GoogleSiginBtn {
                    FirebAuth.share.signinWithGoogle(presenting: getRootViewController()) { error in
                        // TODO: Handle ERROR
                    }
                } // GoogleSiginBtn

                Button(action: { isShowingSignUp = true }) {
                    Text("Don't have an account? Sign up")
                        .font(.footnote)
                        .padding(.top, 8)
                }
            } // VStack
            .padding(.top, 52)
            Spacer()
        }
        .sheet(isPresented: $isShowingSignUp) {
            SignUpScreen()
        }
    }
}


struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

// MARK: - Email/Password login
extension LoginScreen {
    @MainActor
    private func loginWithEmail() async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            UserDefaults.standard.set(true, forKey: "signIn")
        } catch {
            // Handle error UI if needed
            print("Login error:", error.localizedDescription)
        }
    }
}

