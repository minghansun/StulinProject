//
//  File.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

extension TankWorld {
    func actionSendMessage(tank: Tank, sendMessageAction: SendMessageAction){
        if isDead(tank){return}
        logger.addLog(tank, "Sending Message \(sendMessageAction)")

        if !isEnergyAvailable(tank, amount: Constants.costOfSendingMessage){
            logger.addLog(tank, "Insufficient energy to send message")
            return
        }

        applyCost(tank, amount: Constants.costOfSendingMessage)
        MessageCenter.sendMessage(id: sendMessageAction.key, message: sendMessageAction.message)
    }

    func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction){
        if isDead(tank){return}
        logger.addLog(tank, "Receiving Message \(receiveMessageAction)")

        if !isEnergyAvailable(tank, amount: Constants.costOfReceivingMessage){
            logger.addLog(tank, "Insufficient energy to send message")
            return
        }

        applyCost(tank, amount: Constants.costOfReceivingMessage)
        let message = MessageCenter.receiveMessage(id: receiveMessageAction.key)
        tank.setReceivedMessage(message: message)
    }

    func actionRunRadar (tank: Tank, runRadarAction: RadarAction) {
        let r = runRadarAction.range //for simplicity
        if isDead(tank){return}

        logger.addLog(tank, "Running radar with radius \(r)")
        if !isEnergyAvailable(tank, amount: Constants.costOfRadarByUnitDistance[r]) {
            logger.addLog(tank, "Insufficient energy to run radar")
            return
        }

        applyCost(tank, amount: Constants.costOfRadarByUnitDistance[r])

        var result = RadarResult()
        for e in findObjectsWithinRange(tank.position, range: r) {
            result.information.append((position:e.position,id:e.id, energy:e.energy))
        }

        tank.newRadarResult(result: result)
    }

    func actionSetShield (tank: Tank, setShieldsAction: ShieldAction) {
        if isDead(tank) {return}

        logger.addLog(tank, "setting sheild with energy \(setShieldsAction.power)")
        if !isEnergyAvailable(tank, amount: setShieldsAction.power) {
            logger.addLog(tank, "Insufficient energy to set shield")
            return
        }

        tank.addEnergyToShield(amount: setShieldsAction.power)
    }

    func actionMove (tank: Tank, moveAction: MoveAction) {
        if isDead(tank) {return}

        logger.addLog(tank, "Moving \(moveAction.distance) towards \(moveAction.direction)")
        if !isEnergyAvailable(tank, amount: Constants.costOfFMovingTanksPerUnitDistance[moveAction.distance]) {
            logger.addLog(tank, "Insufficient energy to move")
            return
        }

        let newPlace = newPosition(position: tank.position, direction: moveAction.direction, magnitude: moveAction.distance)

        switch newPlace {
        case let a where !isValidPosition(a) : logger.addLog(tank, "the move fails as \(newPlace) is not a valid position")
            return

        case let c where isPositionEmpty(c) : doTheMoving(object: tank, destination: newPlace)
        logger.addLog(tank, "the move has succeeded as \(newPlace) is empty")

        case let b where grid[b.row][b.col]!.objectType == .Tank : logger.addLog(tank, "the move fails as there is a tank in the destination which is \(newPlace)")
            return
        default :
        tank.useEnergy(amount: grid[newPlace.row][newPlace.col]!.energy * Constants.mineStrikeMultiple)
        logger.addLog(tank, "the move has succeeded, but due to the presence of an explosive, it loses \(grid[newPlace.row][newPlace.col]!.energy * Constants.mineStrikeMultiple)")
        doTheMoving(object: tank, destination: newPlace)

            }
        // this switch statement could be a source of error

        }


    func actionFireMissle (tank: Tank, fireMissleAction: MissileAction) {
        let destination = fireMissleAction.absoluteDestination
        if isDead(tank) {return}
        tank.useEnergy(amount: fireMissleAction.power)

        logger.addLog(tank, "firing missle to \(destination) with \(fireMissleAction.power) power")
        if !isEnergyAvailable(tank, amount: Constants.costOfLaunchingMissle * distance(tank.position, destination)) {
            logger.addLog(tank, "Insufficient energy to fire missile")
            return
        }

        if !isValidPosition(destination) {
            logger.addLog(tank, "Firing missile failed because \(destination) is not a valid location")
            return}

        if !isPositionEmpty(destination) {
            let objective = grid[destination.row][destination.col]!

            let currentEnergy = objective.energy
            objective.useEnergy(amount: fireMissleAction.power * Constants.missileStrikeMultiple)
            logger.addLog(tank, "hit \(objective.id) at \(objective.position) causing \( fireMissleAction.power * Constants.missileStrikeMultiple) damage")
            if isDead(objective) {
                tank.addEnergy(amount: currentEnergy / 4)
                logger.addLog(tank, "took \(currentEnergy / 4) energy from \(objective.id)")
            }
        } // this could be a major source of error

        for e in getSurroundingPositions(destination) where grid[e.row][e.col] != nil {
            let currentEnergy = grid[e.row][e.col]!.energy
            grid[e.row][e.col]!.useEnergy(amount: fireMissleAction.power * Constants.missileStrikeMultiple / 4)
            logger.addLog(tank, "hit \(grid[e.row][e.col]!.id) at \(e) causing \(fireMissleAction.power * Constants.missileStrikeMultiple / 4) Splash damage")
            if isDead(grid[e.row][e.col]!) {
                tank.addEnergy(amount: currentEnergy / 4)
                logger.addLog(tank, "took \(currentEnergy / 4) energy from \(grid[e.row][e.col]!.id)")
            }

        }
    }

    func actionDropMine (tank: Tank, dropMineAction: DropMineAction) {
        if isDead(tank) {return}
        let type = (dropMineAction.isRover) ? "rover" : "mine"

        logger.addLog(tank, "dropping \(type) with energy \(dropMineAction.power)")

        if !isEnergyAvailable(tank, amount: Constants.costOfReleasingMine) {
            logger.addLog(tank, "Insufficient energy to drop \(type)")
            return
        }
        if findFreeAdjacent(tank.position) == nil{
            logger.addLog(tank, "no free adjacent space to drop \(type)")
        }

        if !dropMineAction.isRover  {
            let dropPosition = findFreeAdjacent(tank.position)!
            grid[dropPosition.row][dropPosition.col] = Mine(mineorRover: .Mine, row: dropPosition.row, col: dropPosition.col, energy: dropMineAction.power, id: dropMineAction.id, moveDirection: dropMineAction.moveDirection)
            logger.addLog(tank, "a mine has been dropped at \(dropPosition), with \(dropMineAction.power) units of energy")
        } else if isEnergyAvailable(tank, amount: Constants.costOfReleasingRover) {
            let dropPosition = findFreeAdjacent(tank.position)!
            grid[dropPosition.row][dropPosition.col] = Mine(mineorRover: .Rover, row: dropPosition.row, col: dropPosition.col, energy: dropMineAction.power, id: dropMineAction.id, moveDirection : nil)
            logger.addLog(tank, "a rover has been dropped, at \(dropPosition), with \(dropMineAction.power) units of power")

        }
    } // I assumed that the drop direction is always random


}
