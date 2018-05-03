//
//  TankWorld.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

class TankWorld {
    var grid : [[GameObject?]]
    var turn: Int = 0
    
    init () {
        grid = Array(repeating: Array(repeating: nil, count: 15), count: 15)
    }
}
