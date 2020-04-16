//
//  OrderListener.swift
//  iCoffee
//
//  Created by Chase McElroy on 4/14/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation
import Firebase

class OrderListener: ObservableObject {
    
    @Published var activeOrders: [Order]!
    @Published var completedOrders: [Order]!
    
    init() {
        downloadOrder()
    }
    
    func downloadOrder() {
        
            FirebaseReference(.Order).addSnapshotListener { (snapshot, error) in
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let basketData = snapshot.documents.first!.data()
                    
                    getDrinksFromFirestore(withIds: basketData[kDRINKIDS] as? [String] ?? []) { (allDrinks) in
                        let basket = OrderBasket()
                        basket.owenerId = basketData[kOWNERID] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allDrinks
                        self.orderBasket = basket
                    }
                }
            }

    }
}

func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArray: [Drink]) -> Void) {
    var count = 0
    var drinkArray: [Drink] = []
    
    if withIds.count == 0 {
        completion(drinkArray)
        return
    }
    for drinkId in withIds {
        FirebaseReference(.Menu).whereField(kID, isEqualTo: drinkId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let drinkData = snapshot.documents.first!
                
                drinkArray.append(Drink(id: drinkData[kID] as? String ?? UUID().uuidString, name: drinkData[kNAME] as? String ?? "Unknown", imageName: drinkData[kIMAGENAME] as? String ?? "Unknown", category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold, description: drinkData[kDESCRIPTION] as? String ?? "Description is missing", price: drinkData[kPRICE] as? Double ?? 0.0))
                count += 1
            } else {
                print("have no drink")
                completion(drinkArray)
            }
            
            if count == withIds.count {
                completion(drinkArray)
            }
            
        }
    }
}
