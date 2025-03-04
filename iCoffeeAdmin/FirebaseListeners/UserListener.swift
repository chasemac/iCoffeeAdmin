//
//  UserListener.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/16/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation
import Firebase

func downloadUser(userId: String, completion: @escaping(_ user: FUser?) -> Void) {
    FirebaseReference(.User).whereField(kID, isEqualTo: userId).getDocuments { (snapshot, error) in
        
        guard let snapshot  = snapshot else {return}
        
        if !snapshot.isEmpty {
            let userData = snapshot.documents.first!.data()
            completion(FUser(userData as NSDictionary))
        } else {
            completion(nil)
        }
    }
}
