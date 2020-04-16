//
//  OrderDetailView.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/15/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    
    var order: Order
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Customer")) {
                    NavigationLink(destination: UserDetailView(order: order)) {
                        Text(order.customerName)
                            .font(.headline)
                    }
                } // end of section
                Section(header: Text("Order Items")) {
                        ForEach(self.order.orderItems) { drink in
                            HStack {

                            Text(drink.name)
                            Spacer()
                            Text("\(drink.price.clean)")
                                } // End of hstack

                        }
                } // end of section
            } // end of list
        } // end of vstack
            .navigationBarTitle("Order", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.markAsCompleted()
            }, label: {
                Text("Complete Order")
            })
        )
    } // end of body
    
    private func markAsCompleted() {
        if !order.isCompleted {
            self.order.isCompleted = true
            order.saveOrderToFirestore()
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: Order())
    }
}
