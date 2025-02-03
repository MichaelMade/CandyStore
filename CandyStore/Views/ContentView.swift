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
        
    @ObservedObject var authService = AuthenticationService()
    
    var body: some View {
        
        if authService.userAccount == nil {
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
        ContentView()
    }
}
