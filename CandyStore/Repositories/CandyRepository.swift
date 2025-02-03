//
//  CandyRepository.swift
//  CandyStore
//
//  Created by Michael Moore on 4/1/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class CandyRepository: ObservableObject {
    
    private let path: String = "candies"
    private let store = Firestore.firestore()
    
    @Published var candies: [Candy] = []
    
    @Published var errorMessage: String?
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getCandies()
    }
    
    func getCandies() {
        
        store.collection(path).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                print("Error getting candies: \(error)")
                self.errorMessage = error.localizedDescription
                return
            }
            
            self.candies = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Candy.self)
            } ?? []
        }
    }
}
