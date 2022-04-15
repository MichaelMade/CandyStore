//
//  CartView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/8/22.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                let columns: [GridItem] = Array(repeating: .init(.fixed(125.0), alignment: .center), count: 1)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach($viewModel.cartItemViewModels) { $shopItemViewModel in
                            CartItemView(shopViewModel: _viewModel, shopItemViewModel: shopItemViewModel)
                        }
                    }
                }
                VStack(spacing: 5) {
                    Text("Subtotal")
                        .foregroundColor(Color(.blue))
                        .font(.title2)
                        .fontWeight(.regular)
                        .kerning(2)
                    Text(String(format: "$%.2f", viewModel.cartTotal))
                        .foregroundColor(Color(.blue))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 100.0)
                    Text(String(format: "§%.2f", viewModel.satsBack))
                        .foregroundColor(Color(.blue))
                        .font(.title)
                        .fontWeight(.light)
                    
                }
                .background(Color(.clear).opacity(0.0))
                .padding(.bottom)
            }
            .navigationBarTitle("Candy Cart 🍭")
            .navigationBarTitleTextColor(.accentColor)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
    

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        
        return CartView().environmentObject(ShopViewModel())
    }
}
