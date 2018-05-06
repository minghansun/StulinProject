//
//  TankWorldDisplay.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation
extension TankWorld{
    
}
/*
class Grid{
    var grid = [[GameObject?]](repeating: [GameObject?](repeating: nil, count: 15), count: 15)
    func formatToGrid(_ value: String)-> String{
        var yes = ""
        for _ in 0..<10 - value.count{
            yes += " "
        }
        yes += value + "|"
        return yes
    }
    func printGrid(){
        for _ in 0...164{
            print("_", terminator: "")
        }
        print("_")
        for y in 0...14{
            var row0 = "|"
            var row1 = "|"
            var row2 = "|"
            var row3 = "|"
            var row4 = "|"
            for x in 0...14{
                row4 += "__________|"
                if let thing = grid[y][x]{
                    row0 += formatToGrid(thing.name)
                    row1 += formatToGrid(String(thing.energy))
                    row2 += formatToGrid("(\(y), \(x))")
                    row3 += formatToGrid(thing.type)
                }
                else{
                    row0 += "          |"
                    row1 += "          |"
                    row2 += "          |"
                    row3 += "          |"
                }
            }
            print(row0)
            print(row1)
            print(row2)
            print(row3)
            print(row4)
        }
    }
}
*/

