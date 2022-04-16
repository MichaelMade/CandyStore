//
//  LoginView.swift
//  CandyStore
//
//  Created by Michael Moore on 3/30/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuthCombineSwift

struct LoginView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    @State var authError = false
        
    var body: some View {
        
        VStack(spacing: 10) {
            Image("logo")
                .resizable()
                .scaledToFit()
                        
            SignInWithAppleButtonView(authError: authError)
                .environmentObject(authService)
            
            Button("Skip") {
                authService.skipLogin()
            }
            .padding(.top)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationService())
    }
}
