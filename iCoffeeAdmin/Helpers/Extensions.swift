//
//  Extensions.swift
//  iCoffeeAdmin
//
//  Created by Chase McElroy on 4/15/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
