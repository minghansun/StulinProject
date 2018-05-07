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

let y = Tank(row: 3, col: 3, energy: 2000, id: "tank1", instructions: " ")
let z = GameObject(row: 5, col: 5, objectType: .Mine, energy: 20000, id: "mine123")
let w = Mine(mineorRover: .Rover, row: 6, col: 7, energy: 2000000, id: "pernicious")
x.addGameObject(adding: y)
x.addGameObject(adding: z)
x.addGameObject(adding: w)
x.printGrid()

print (x.isPositionEmpty(Position(4,5)))

print (x.findAllGameObjects())

print (x.getLegalSurroundingPositions(Position(14,14)))

print (x.findObjectsWithinRange(Position(6,6), range: 3))

print (x.findAllTanks())

print (x.findAllRovers())

print (x.randomizeDirection())
