//
//  main.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

var x = TankWorld()

var tank1 = Tank(row: 3, col: 3, energy: 10000, id: "454", instructions: "")
var tank2 = Tank(row: 4, col: 6, energy: 15000, id: "564", instructions: "")
var mine1 = Mine(mineorRover: .Mine, row: 10, col: 10, energy: 200, id: "465", moveDirection: nil)
var rover1 = Mine(mineorRover: .Rover, row: 7, col: 4, energy: 50, id: "123", moveDirection: .east)

x.addGameObject(adding: tank1)
x.addGameObject(adding: tank2)
x.addGameObject(adding: mine1)
x.addGameObject(adding: rover1)

print (x.findObjectsWithinRange(Position(4,4), range: 2))


