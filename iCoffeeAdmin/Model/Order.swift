//
//  Order.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/15/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation

class Order: Identifiable {
    var id: String!
    var customerId: String!
    var orderItems: [Drink] = []
    var amount: Double!
    var customerName: String!
    var isCompleted: Bool!
    
    func saveOrderToFirestore() {
        
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            
            if error != nil {
                print("Error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}

func orderDictionaryFrom(_ order: Order) -> [String: Any] {
    
    var allDrinkIds: [String] = []
    
    for drink in order.orderItems {
        allDrinkIds.append(drink.id)
    }
    
    return NSDictionary(objects: [order.id,
                                  order.customerId,
                                  allDrinkIds,
                                  order.amount,
                                  order.customerName,
                                  order.isCompleted
        ], forKeys: [kID as NSCopying,
                     kCUSTOMERID as NSCopying,
                     kDRINKIDS as NSCopying,
                     kAMOUNT as NSCopying,
                     kCUSTOMERNAME as NSCopying,
                     kISCOMPLETED as NSCopying,
                     
    ]) as! [String : Any]
}
