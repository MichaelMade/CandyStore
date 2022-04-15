//
//  ShopViewModel.swift
//  CandyStore
//
//  Created by Michael Moore on 4/6/22.
//

import Foundation
import Combine

class ShopViewModel: ObservableObject {
    
    @Published var shopItemViewModels: [ShopItemViewModel]
    @Published var cartItemViewModels: [ShopItemViewModel]
    @Published var candyRepository = CandyRepository()
    @Published var cartTotal = 0.0000 {
        willSet {
            // Calculate sats back when cart total changes
            satsBack = preciseRound((newValue / (btcToUsd * satsValue)) * satsBackPercent, precision: .thousands)
        }
    }
    @Published var satsBack = 0.0
    
    private var btcToUsd: Double = 42612.0
    private var satsValue = 0.00000001
    private var satsBackPercent = 0.10
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        shopItemViewModels = []
        cartItemViewModels = []
        
        getCandies()
    }
    
    func getCandies() {
        candyRepository.$candies.map { candy in
            candy.map(ShopItemViewModel.init)
        }
        .assign(to: \.shopItemViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addToCart(item: ShopItemViewModel) {
        
        if item.cartQuantity < item.shopItem.quantity {
            item.cartQuantity += 1
            item.inCart = true
            cartTotal = preciseRound(cartTotal + item.shopItem.price, precision: .thousands)
            
            if !cartItemViewModels.contains(where: { $0.id == item.id}) {
                cartItemViewModels.append(item)
            }
        }
    }
    
    func removeFromCart(item: ShopItemViewModel) {
        
        if item.cartQuantity > 0 {
            item.cartQuantity -= 1
            
            cartTotal = preciseRound(abs(cartTotal - item.shopItem.price), precision: .thousands)
        }
        
        if item.cartQuantity == 0 {
            
            if let index = cartItemViewModels.firstIndex(where: { $0.id == item.id}) {
                cartItemViewModels.remove(at: index)
            }
            
            item.inCart = false
        }
    }
}
