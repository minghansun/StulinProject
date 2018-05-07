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
    
    subscript (_ index1: Int, _ index2: Int) -> GameObject? {
        get {
            return grid[index1][index2]
        }
        set {
            grid[index1][index2] = newValue
        }
    }

    init () {
        grid = Array(repeating: Array(repeating: nil, count: 15), count: 15)
    }
    
    func addGameObject (adding gameObject: GameObject) {
        grid[gameObject.position.row][gameObject.position.col] = gameObject
    }
}
