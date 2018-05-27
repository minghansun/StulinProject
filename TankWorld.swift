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
    var turn = 0
    var numberLivingTanks = 0
    
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
    
    func populateTheTankWorld () {
        addGameObject(adding: Tank(row: 4, col: 4, energy: 10000, id: "sun1", instructions: "fire"))
        addGameObject(adding: Tank(row: 2, col: 3, energy: 20000, id: "sun2", instructions: "defend"))
        addGameObject(adding: Tank(row: 5, col: 6, energy: 25000, id: "sun3", instructions: "donothing"))
    }
    
    
    func addGameObject (adding gameObject: GameObject) {
        grid[gameObject.position.row][gameObject.position.col] = gameObject
        if gameObject.objectType == .Tank {numberLivingTanks += 1}
    }
    
    func handleRadar (tank: Tank) {
        guard let radarAction = tank.preActions[.Radar] else {return}
        actionRunRadar(tank: tank, runRadarAction: radarAction as! RadarAction)
    }
    
    func handleMove (tank: Tank) {
        guard let moveAction = tank.postActions[.Move] else {return}
        actionMove(tank: tank, moveAction: moveAction as! MoveAction)
    }
    
    func handleShields(tank: Tank) {
        guard let shieldAction = tank.preActions[.Shields] else {return }
        actionSetShield(tank: tank, setShieldsAction: shieldAction as! ShieldAction)
    }
    
    func handleMissle (tank: Tank) {
        guard let missleAction = tank.postActions[.Missle] else {return}
        actionFireMissle(tank: tank, fireMissleAction: missleAction as! MissileAction)
    }
    
    func handleSendMessage (tank: Tank) {
        guard let sendMessageAction = tank.preActions[.SendMessage] else {return}
        actionSendMessage(tank: tank, sendMessageAction: sendMessageAction as! SendMessageAction)
    }
    
    func handleReceiveMessage (tank: Tank) {
        guard let receieveMessageAction = tank.preActions[.ReceiveMessage] else {return}
        actionReceiveMessage(tank: tank, receiveMessageAction: receieveMessageAction as! ReceiveMessageAction)
    }
    
    func handleDropMine (tank: Tank) {
        guard let dropMineAction = tank.postActions[.DropMine] else {return}
        actionDropMine(tank: tank, dropMineAction: dropMineAction as! DropMineAction)
    }
    
    func doTurn () {
        var allObjects = findAllGameObjects()
        allObjects = randomizeGameObjects(gameObjects: allObjects)
        
        for e in allObjects {
            e.liveSupport()
        }
        
        var allRovers = findAllRovers()
        allRovers = randomizeGameObjects(gameObjects: allRovers)
        for e in allRovers where findFreeAdjacent(e.position) != nil {
            if e.moveDirection == nil {
                doTheMoving(object: e, destination: findFreeAdjacent(e.position)!)
            }
            else {
                doTheMoving(object: e, destination: newPosition(position: e.position, direction: e.moveDirection!, magnitude: 1))
            }
        }
        
        var allTanks = findAllTanks()
        func randomize (_ tanks: [Tank] = allTanks)  {
            allTanks = randomizeGameObjects(gameObjects: tanks)
        } // just an unneccessary function to make code look nicer
        
        randomize()
        for a in allTanks {
            handleRadar(tank: a)
            handleSendMessage(tank: a)
            handleReceiveMessage(tank: a)
            handleShields(tank: a)
        }
        randomize()
        for b in allTanks {
            handleDropMine(tank: b)
            handleMissle(tank: b)
            handleMove(tank: b)
        }
        
        turn += 1
    }
    
    func runOneTurn () {
        doTurn()
        print(gridReport())
    }
    
    func driver () {
        populateTheTankWorld()
        print(gridReport())
        while findWinner() == nil {
            runOneTurn()
        }
        
    }
}
