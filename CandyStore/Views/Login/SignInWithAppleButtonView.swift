//
//  SignInWithAppleButtonView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/5/22.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    @State var authError = false
    
    var body: some View {
        SignInWithAppleButton(
            onRequest: { request in
                
                let nonce = Utils.randomNonceString()
                authService.nonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = Utils.sha256(nonce)
                
            }) { result in
                
                switch result {
                case .success(let auth):
                    authService.linkFirebase(auth)
                case .failure(let error):
                    authService.errorMessage = error.localizedDescription
                    authError = true
                }
                
            }
            .frame(width: 280, height: 60)
            .alert(isPresented: $authError) {
                Alert(
                    title: Text("Login Error :("),
                    dismissButton: .default(Text("OK")) {
                        authError = false
                    }
                )
            }
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        return SignInWithAppleButtonView()
    }
}

