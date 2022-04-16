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
    @State var showMenu = false
    
    @SceneStorage("selectedTab")
    private var selectedTab = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                TabView(selection: $selectedTab) {
                    
                    NavigationView {
                        ShopView()
                            .navigationBarTitle("Candy Shop 🍭")
                            .navigationBarTitleTextColor(.accentColor)
                            .navigationBarItems(trailing: (
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
                            ))
                    }
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(1)
                    .navigationViewStyle(StackNavigationViewStyle())
                    
                    NavigationView {
                        CartView()
                            .navigationBarTitle("Candy Cart 🍭")
                            .navigationBarTitleTextColor(.accentColor)
                            .navigationBarItems(trailing: (
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
                            ))
                    }
                    .tabItem {
                        Image(systemName: "cart")
                    }
                    .tag(2)
                    .navigationViewStyle(StackNavigationViewStyle())
                }
                .environmentObject(shopViewModel)
            }
            
            if self.showMenu {
                NavigationView {
                    MenuView().environmentObject(shopViewModel)
                        .background(Color("PrimaryColor"))
                        .onTapGesture {
                            self.showMenu.toggle()
                        }
                        .navigationBarItems(trailing: (
                            Button(action: {
                                withAnimation {
                                    self.showMenu.toggle()
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                            }
                        ))
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .leading)
                    )
                )
                .zIndex(1)
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(shopViewModel: ShopViewModel()).environmentObject(AuthenticationService())
    }
}
