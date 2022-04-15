//
//  Candy.swift
//  CandyStore
//
//  Created by Michael Moore on 4/8/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Candy: Identifiable, Codable {
    
    // Firebase Data
    @DocumentID var id: String?
    
    var name: String
    var price: Double
    var imageUrl: String
    var quantity: Int
}

#if DEBUG
var candyTestData = (1...10).map { i in
    Candy(name: "Peppermint Candy", price: 1.0000, imageUrl: "https://firebasestorage.googleapis.com/v0/b/candystore-fb2e3.appspot.com/o/Asset%2015%403x.png?alt=media&token=943f781d-a549-4ce3-a602-f73b1dc15a99", quantity: i)
}

var outOfStockCandy = Candy(name: "Candy Corn", price: 0.01, imageUrl: "https://firebasestorage.googleapis.com/v0/b/candystore-fb2e3.appspot.com/o/Asset%2015%403x.png?alt=media&token=943f781d-a549-4ce3-a602-f73b1dc15a99", quantity: 0)
#endif

