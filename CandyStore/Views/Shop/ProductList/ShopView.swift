//
//  ShopView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/8/22.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        
        NavigationView {
            
            let columns: [GridItem] = Array(repeating: .init(.fixed(170.0), alignment: .center), count: 2)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach($viewModel.shopItemViewModels) { $shopItemViewModel in
                        ShopItemView(shopViewModel: _viewModel, shopItemViewModel: shopItemViewModel)
                    }
                }
                .navigationBarTitle("Candy Shop 🍭")
                .navigationBarTitleTextColor(.accentColor)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
    
    struct ProductView_Previews: PreviewProvider {
        static var previews: some View {
            
            return ShopView().environmentObject(ShopViewModel())
        }
    }
