//
//  ContentView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseAuthCombineSwift

struct ContentView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        
        if Auth.auth().currentUser == nil {
            LoginView()
                .environmentObject(authService)
        } else {
            MainView()
                .environmentObject(authService)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationService())
    }
}
