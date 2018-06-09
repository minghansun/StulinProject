//
//  TankWorldDisplay.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation
//import Glibc

extension TankWorld {
    func formatToGrid(_ value: String)-> String {
        var string = ""
        for _ in 0..<10 - value.count{
            string += " "
        }
        string += value + "|"
        return string
    }
    
    func gridReport() {
        for _ in 0...164{
            print("-", terminator: "")
        }
        print("-")
        for y in 0...14{
            var row0 = "|"
            var row1 = "|"
            var row2 = "|"
            var row3 = "|"
            var row4 = "|"
            for x in 0...14 {
                row4 += "----------|"
                if let thing = grid[y][x] {
                    row0 += formatToGrid(thing.id)
                    row1 += formatToGrid(String(thing.energy))
                    row2 += formatToGrid("(\(y), \(x))")
                    row3 += formatToGrid(String(describing: thing.objectType))
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
    
    /*func succintReport () {
        
        for e in findAllGameObjects() {
            print("\(e.id) \(e.position) \(e.energy)")
        }
        
    }*/
}

