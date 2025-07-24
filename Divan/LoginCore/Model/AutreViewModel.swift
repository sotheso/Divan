//
//  AutreViewModel.swift
//  Divan
//
//  Created by Sothesom on 31/04/1404.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class AutreViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser : User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email:String, password: String) async throws {
        
    }
    
    func creatUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // کاربر میسازیم
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // استاتوس کاربری ایجاد شده
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            
            // رمز گذاری کاربر
            let encodedUser = try Firestore.Encoder().encode(user)
            // آپلود کاربر
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch {
            print ("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try? Auth.auth().signOut()
            self.currentUser = nil
            self.userSession = nil
        } catch {
            
        }
    }
    
    func deleteAccount() {
        
    }
    
    // get data users واکنشی for profileView in settingView
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // get users data for firebase database
        guard let snapshot = try? await Firestore.firestore().collection("users").document().getDocument() else { return }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
