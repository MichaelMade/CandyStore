//
//  AuthenticationService.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import AuthenticationServices
import Combine

class AuthenticationService: ObservableObject {
    
    @Published var userAccount: User?
    private var cancellables = Set<AnyCancellable>()
    var nonce: String = ""
    var errorMessage: String = ""
    
    init() {
        // Verify a user isn't already authenticated
        do {
            let storedUser = try Auth.auth().getStoredUser(forAccessGroup: Auth.auth().userAccessGroup)
            self.userAccount = storedUser
        } catch let error {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}

extension AuthenticationService {
    
    // Firebase Auth is linked with the Apple Auth data
    func linkFirebase(_ authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(providerID:.apple,
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let userResult = result else {
                    self.errorMessage = "User not found"
                    return
                }
                
                print("User \(userResult.user.uid) signed in")
                
                self.userAccount = userResult.user
            }
        }
    }
    
    func skipLogin() {
        Auth.auth().signInAnonymously { userResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let userResult = userResult else {
                self.errorMessage = "User not found"
                return
            }
            
            print("Anonymous user signed in")
            
            self.userAccount = userResult.user
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userAccount = nil
    }
}

