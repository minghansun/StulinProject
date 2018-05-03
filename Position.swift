//
//  Position.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

struct Position : CustomStringConvertible {
    var row: Int
    var col: Int
    
    init(_ row: Int, _ col: Int) {
        self.row = row
        self.col = col
    }
    
    func checker () {
        //a helper method to check whether the destination is out of the grid.
    }
    
    /*mutating func move (orientation: direction, distance: Int) {
        switch orientation {
        case direction.north : x -= distance
        case direction.south : x += distance
        case direction.east : y += distance
        case direction.west: y -= distance
        case direction.northeast : x -= distance
        y += distance
        case direction.northwest : x -= distance
        y -= distance
        case direction.southeast : x += distance
        y += distance
        case direction.southwest : x += distance
        y += distance
        }
    }*/
    
    
    var description: String {
        return "(\(row), \(col)"
    }
}
