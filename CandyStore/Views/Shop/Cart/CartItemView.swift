//
//  CartItemView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/14/22.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreMedia

struct CartItemView: View {
    
    @EnvironmentObject var shopViewModel: ShopViewModel
    @ObservedObject var shopItemViewModel: ShopItemViewModel
    
    var body: some View {
        
        HStack(alignment: .center) {
            HStack {
                WebImage(url: URL(string: shopItemViewModel.shopItem.imageUrl))
                    .placeholder(Image(systemName: "photo"))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .shadow(radius: 5)
                    .scaledToFit()
                    .padding(2.0)
                    .frame(width: 60.0, height: 60.0)
                
                VStack(spacing: 10.0) {
                    Text(shopItemViewModel.shopItem.name)
                        .kerning(1.75)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .shadow(radius: 0.75)
                    
                    Text(String(format: "$%.2f", shopItemViewModel.shopItem.price))
                        .kerning(1)
                        .foregroundColor(shopItemViewModel.inStock ? Color(.darkGray) : Color(.lightGray))
                        .font(.system(size: 14.0, weight: .bold, design: .rounded))
                }
                .frame(width: 125.0, alignment: .center)
                .scaledToFill()
            }
            
            Divider()
            
            VStack(spacing: 15.0) {
                Text("Cart: \(shopItemViewModel.cartQuantity)")
                    .foregroundColor(Color(.darkGray))
                    .font(.system(size: 15.0, weight: .light, design: .rounded))
                Stepper("", onIncrement: {
                    shopViewModel.addToCart(item: shopItemViewModel)
                }, onDecrement: {
                    shopViewModel.removeFromCart(item: shopItemViewModel)
                })
                .frame(width: 100, height: 20)
                .foregroundColor(Color(.lightGray))
                .frame(alignment: .center)
            }
        }
        .padding()
        .frame(width: 350.0, height: 125.0, alignment: .center)
        .background(Color("PrimaryColor"))
        .cornerRadius(10.0)
        .shadow(color: Color("SecondaryColor"), radius: 5)
        .fixedSize()
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        return CartItemView(shopItemViewModel: ShopItemViewModel(candy: candyTestData[0]))
    }
}
