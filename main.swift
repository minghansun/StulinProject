//
//  main.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

var x = TankWorld()

print (x.isValidPosition(Position(2,15)))

print (x.distance(Position(2,2), Position(5,5)))

print (x.newPosition(position: Position(0,0), direction: .southeast, magnitude: 5))
