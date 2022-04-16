//
//  MainView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authService: AuthenticationService
    @ObservedObject var shopViewModel = ShopViewModel()
    
    @SceneStorage("selectedTab")
        private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ShopView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                }
                .tag(2)
        }
        .environmentObject(shopViewModel)
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(shopViewModel: ShopViewModel()).environmentObject(AuthenticationService())
    }
}
