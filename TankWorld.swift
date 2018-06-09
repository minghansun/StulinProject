//
//  TankWorld.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation
//import Glibc


class TankWorld {
    var grid : [[GameObject?]]
    var turn : Int
    var numberLivingTanks = 0
    var logger = Logger()

    init () {
        grid = Array(repeating: Array(repeating: nil, count: 15), count: 15)
        turn = 1
    }

    func addGameObject (adding gameObject: GameObject) {
        grid[gameObject.position.row][gameObject.position.col] = gameObject
        if gameObject.objectType == .Tank {numberLivingTanks += 1}
    }
    
    func remove (_ obj: GameObject) {
        grid[obj.position.row][obj.position.col] = nil
        if obj.objectType == .Tank {numberLivingTanks -= 1}
    }

    func populateTheTankWorld () {
        //addGameObject(adding: tankSY(row: 3, col: 6, energy: 100000, id: "t2", instructions: "none"))
        //addGameObject(adding: tankSY(row: 4, col: 6, energy: 200000, id: "t3", instructions: "none"))
        addGameObject(adding: fire(row: 4, col: 4, energy: 5000000, id: "t1", instructions: "none"))
        addGameObject(adding: blankTank(row: 2, col: 2, energy: 2000000, id: "bt", instructions: "none"))
        //addGameObject(adding: Mine(mineorRover: .Rover, row: 4, col: 4, energy: 4000, id: "rover1", moveDirection: .north))
        /*addGameObject(adding: Mine(mineorRover: .Mine, row: 3, col: 7, energy: 1000, id: "mine", moveDirection: nil))*/
    }

    //handling helpers
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

    //end of handling helpers

    func doTurn () {
        let allObjects = randomizeGameObjects(gameObjects: findAllGameObjects())

        for e in allObjects {
            e.liveSupport()
            if e.objectType == .Tank{
                logger.addLog(e, "used \(Constants.costLiveSupportTank) energy as life support and has \(e.energy) left")
            }
            if e.objectType == .Mine{
                logger.addLog(e, "used \(Constants.costLiveSupportMine) energy as life support and has \(e.energy)  left")
            }
            if e.objectType == .Rover{
                logger.addLog(e, "used \(Constants.costLiveSupportRover) energy as life support and has \(e.energy) left")
            }
        }
        
        movingRovers()

        var allTanks = findAllTanks()
            allTanks = randomizeGameObjects(gameObjects: allTanks)

        for a in allTanks {
            a.computePreActions()
            handleRadar(tank: a)
            handleSendMessage(tank: a)
            handleReceiveMessage(tank: a)
            handleShields(tank: a)
        }
        
        allTanks = randomizeGameObjects(gameObjects: allTanks)
        
        for b in allTanks {
            b.computePostActions()
            handleDropMine(tank: b)
            handleMissle(tank: b)
            handleMove(tank: b)
        }
        
        for e in logger.data[turn]! {
            print (e)
        }
        
        logger.newRound()

        turn += 1

        for e in allTanks {
            e.clearActions()
            e.clearShieldEnergy()
        }
    }
    
    func runOneTurn () {
        print ("")
        print ("RUNNING TURN \(turn)")
        print ("number of tanks standing \(numberLivingTanks)")
        print ("number of rovers standing \(findAllRovers().count)")
        print ("")
        doTurn()
        gridReport()
    }

    func driver () {
        populateTheTankWorld()
        gridReport()
        while findWinner() == nil {
            runOneTurn()
        }
        print ("game is over")
    }
}
