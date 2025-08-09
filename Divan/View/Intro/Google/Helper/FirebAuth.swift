//
//  FirebAuth.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 12/5/22.
//

import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase

struct FirebAuth {
    static let share = FirebAuth()
    
    private init() {}
    
    func signinWithGoogle(presenting: UIViewController,
                          completion: @escaping (Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Configure Google Sign-In
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        // Start the sign in flow (new  API)
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            if let error = error {
                completion(error)
                return
            }

            guard let result = result else {
                completion(NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "No sign-in result."]))
                return
            }

            let googleUser = result.user
            guard let idToken = googleUser.idToken?.tokenString else {
                completion(NSError(domain: "GoogleSignIn", code: -2, userInfo: [NSLocalizedDescriptionKey: "Missing ID token."]))
                return
            }
            let accessToken = googleUser.accessToken.tokenString

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    completion(error)
                    return
                }
                UserDefaults.standard.set(true, forKey: "signIn")
                completion(nil)
            }
        }
    }
}
