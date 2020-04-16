//
//  UserDetailView.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/16/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    var order: Order
    @State var user: FUser?
    
    var body: some View {
        List {
            Section {
                Text(user?.fullName ?? "")
                Text(user?.email ?? "")
                Text(user?.phoneNumber ?? "")
                Text(user?.fullAddress ?? "")
            } // end of section
        } // end of list
            .listStyle(GroupedListStyle())
        .navigationBarTitle("User Profile")
            .onAppear {
                self.getUser()
        }
    }
    
    private func getUser() {
        downloadUser(userId: self.order.customerId) { (fuser) in
            self.user = fuser
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(order: Order())
    }
}
