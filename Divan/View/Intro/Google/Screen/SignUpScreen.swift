//
//  SignUpScreen.swift
//
//  Created by Assistant on 2025-08-09.
//

import SwiftUI
import FirebaseAuth

struct SignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                LoginHeader()
                    .padding(.bottom)

                CustomTextfield(text: $email, placeholder: "Email", keyboardType: .emailAddress, textContentType: .emailAddress)
                CustomTextfield(text: $password, placeholder: "Password", isSecure: true, textContentType: .newPassword)
                CustomTextfield(text: $confirmPassword, placeholder: "Confirm Password", isSecure: true, textContentType: .newPassword)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.footnote)
                        .padding(.top, 4)
                }

                CustomButton(title: isLoading ? "Creating..." : "Create Account") {
                    createAccount()
                }

                Spacer()
            }
            .padding(.top, 52)
            .navigationTitle("Sign up")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private func createAccount() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required"
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }
        isLoading = true
        errorMessage = nil
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            // Send verification email
            Auth.auth().currentUser?.sendEmailVerification(completion: { verifyError in
                if let verifyError = verifyError {
                    errorMessage = verifyError.localizedDescription
                }
            })
            dismiss()
        }
    }
}

#Preview {
    SignUpScreen()
}


