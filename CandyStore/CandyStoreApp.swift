//
//  CandyStoreApp.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import SwiftUI
import Firebase

@main
struct CandyStoreApp: App {
    
    @ObservedObject var authService: AuthenticationService
    
    init() {
        FirebaseApp.configure()
        authService = AuthenticationService()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authService)
        }
    }
}
