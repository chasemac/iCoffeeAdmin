//
//  ContentView.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/15/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderListener = OrderListener()
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Active Orders")) {
                    
                    ForEach(self.orderListener.activeOrders ?? []) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            HStack {
                                Text(order.customerName)
                                Spacer()
                                Text("$\(order.amount.clean)")
                            } // end of hstack
                        } //end of nav link
                        
                    } // end of foreach
                }
                // End of section 1
                Section(header: Text("Completed Orders")) {
                    
                    ForEach(self.orderListener.completedOrders ?? []) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            
                            HStack {
                                Text(order.customerName)
                                Spacer()
                                Text("$\(order.amount.clean)")
                            } // end of hstack
                        } //end of nav link
                    } // end of foreach
                }
                // End of section 2
            } // end of list
                .navigationBarTitle("Orders")
        } // end of nav view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
