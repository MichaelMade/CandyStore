//
//  ShopItemViewModel.swift
//  CandyStore
//
//  Created by Michael Moore on 4/14/22.
//

import Foundation
import Combine

class ShopItemViewModel: ObservableObject, Identifiable {
    
    let id: String?
    @Published var shopItem: Candy
    @Published var cartQuantity = 0
    @Published var inCart = false
    @Published var inStock: Bool
    
    init(candy: Candy) {
        shopItem = candy
        id = candy.id
        
        inStock = candy.quantity > 0
    }
}
