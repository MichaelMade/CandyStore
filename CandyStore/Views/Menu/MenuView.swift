//
//  SideMenu.swift
//  CandyStore
//
//  Created by Michael Moore on 4/16/22.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("Hey There Sweet Thing!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .italic()
                    .foregroundColor(.black)
            }
            .padding(.top, 75)
            
            if let email = authService.userAccount?.email {
                HStack {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                    Text("\(email)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 30)
            }
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, 30)
            
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.top, 30)
            
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(Color(.darkGray))
                    .imageScale(.large)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                Text("Logout")
                    .foregroundColor(Color(.darkGray))
                    .font(.headline)
            }
            .onTapGesture {
                authService.signOut()
            }
            .padding(.top, 50)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("AccentColor"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(AuthenticationService())
    }
}
