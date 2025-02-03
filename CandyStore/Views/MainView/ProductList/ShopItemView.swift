//
//  ShopShopItemView.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreMedia

struct ShopItemView: View {
    
    @EnvironmentObject var shopViewModel: ShopViewModel
    @ObservedObject var shopItemViewModel: ShopItemViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(shopItemViewModel.shopItem.name)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 20.0, weight: .heavy, design: .rounded))
                    .kerning(2)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .shadow(radius: 0.75)
                
                WebImage(url: URL(string: shopItemViewModel.shopItem.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "photo")
                    }
                    .onSuccess { image, data, cacheType in
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .shadow(radius: 5)
                    .scaledToFit()
                    .padding(10.0)
                    .frame(maxHeight: 100.0, alignment: .center)
                
                Text(String(format: "$%.2f", shopItemViewModel.shopItem.price))
                    .kerning(1)
                    .foregroundColor(shopItemViewModel.inStock ? Color(.darkGray) : Color(.lightGray))
                    .font(.system(size: 14.0, weight: .bold, design: .rounded))
                
                if shopItemViewModel.inCart {
                    Divider()
                        .padding(.horizontal)
                    Text("Cart: \(shopItemViewModel.cartQuantity)")
                        .foregroundColor(Color(.darkGray))
                        .font(.system(size: 15.0, weight: .light, design: .rounded))
                }
                if !shopItemViewModel.inStock {
                    Text("Out of Stock")
                        .kerning(1.5)
                        .font(.system(size: 16.0, weight: .black))
                        .padding(1)
                }
                
                if !shopItemViewModel.inCart && shopItemViewModel.inStock  {
                    Text("In Stock")
                        .font(.system(size: 12.0, weight: .thin))
                        .foregroundColor(.blue)
                        .padding(1)
                }
            }
            .padding()
            if shopItemViewModel.inCart {
                Stepper("", onIncrement: {
                    withAnimation {
                        shopViewModel.addToCart(item: shopItemViewModel)
                    }
                }, onDecrement: {
                    withAnimation {
                        shopViewModel.removeFromCart(item: shopItemViewModel)
                    }
                })
                .frame(width: 100, height: 20)
                .foregroundColor(Color(.lightGray))
                .frame(alignment: .center)
                .padding(.bottom)
            }
        }
        .onTapGesture {
            if !shopItemViewModel.inCart && shopItemViewModel.inStock  {
                withAnimation {
                    shopViewModel.addToCart(item: shopItemViewModel)
                }
            }
        }
        .frame(width: 170.0, height: 300.0, alignment: .center)
        .fixedSize()
        .background(.blueyBlue)
        .cornerRadius(10.0)
        .shadow(color: .princessPink, radius: 8)
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = ShopItemViewModel(candy: candyTestData[0])
        viewModel.cartQuantity = 5
        viewModel.inCart = false
        viewModel.inStock = true
        
        return ShopItemView(shopItemViewModel: viewModel).environmentObject(ShopViewModel())
    }
}

