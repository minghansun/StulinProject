//
//  main.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation
//import Glibc

var x = TankWorld()
x.populateTheTankWorld()

for _ in 0...4 {
    x.runOneTurn()
}
