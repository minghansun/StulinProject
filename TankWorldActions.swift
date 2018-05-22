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
        //logger.addLog(tank, "Sending Message \(sendMessageAction")

        if !isEnergyAvailable(tank, amount: Constants.costOfSendingMessage){
            //logger.addLog(tank, "Insufficient energy to send message")
            return
        }

        applyCost(tank, amount: Constants.costOfSendingMessage)
        //MessageCenter.sendMessage()
    }

    func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction){
        if isDead(tank){return}
        //logger.addLog(tank, "Receiving Message \(receiveMessageAction)")

        if !isEnergyAvailable(tank, amount: Constants.costOfReceivingMessage){
            //logger.addLog(tank, "Insufficient energy to send message")
            return
        }

        applyCost(tank, amount: Constants.costOfReceivingMessage)
        //let message = MessageCenter.receiveMessage(id: receiveMessageAction.id)
        //tank.setReceivedMessage(receivedMessage: message)
    }
    
    func actionRunRadar (tank: Tank, runRadarAction: RadarAction) {
        let r = runRadarAction.radius //for simplicity
        if isDead(tank){return}
        
        if !isEnergyAvailable(tank, amount: Constants.costOfRadarByUnitDistance[r]) {
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
        
        if !isEnergyAvailable(tank, amount: setShieldsAction.power) {
            return
        }
        
        tank.addEnergyToShield(amount: setShieldsAction.power)
    }
    
    func actionMove (tank: Tank, moveAction: MoveAction) {
        if isDead(tank) {return}
        
        if !isEnergyAvailable(tank, amount: Constants.costOfFMovingTanksPerUnitDistance[moveAction.distance]) {
            return
        }
        
        let newPlace = newPosition(position: tank.position, direction: moveAction.direction, magnitude: moveAction.distance)
        
        switch newPlace {
        case let a where !isValidPosition(a) : return
        case let b where isPositionEmpty(b) : tank.setPosition(newPosition: newPlace)
        case let c where grid[c.row][c.col]!.objectType == .Tank : return
        default : let object = grid[newPlace.row][newPlace.col]!
        tank.useEnergy(amount: object.energy * Constants.mineStrikeMultiple)
            tank.setPosition(newPosition: newPlace)
            }
        // this switch statement could be a source of error
            
        }
    
    
    func actionFireMissle (tank: Tank, fireMissleAction: MissileAction) {
        let destination = fireMissleAction.absoluteDestination
        if isDead(tank) {return}
        
        if !isEnergyAvailable(tank, amount: Constants.costOfLaunchingMissle * distance(tank.position, destination)) {
            return
        }
        
        if !isValidPosition(destination) {return}
        
        if !isPositionEmpty(destination) {
            let currentEnergy = grid[destination.row][destination.col]!.energy
            grid[destination.row][destination.col]!.useEnergy(amount: fireMissleAction.power * Constants.missileStrikeMultiple)
            if isDead(grid[destination.row][destination.col]!) {
                tank.addEnergy(amount: currentEnergy / 4)
            }
        } // this could be a major source of error
        
        for e in getLegalSurroundingPositions(destination) where grid[e.row][e.col] != nil {
            let currentEnergy = grid[e.row][e.col]!.energy
            grid[e.row][e.col]!.useEnergy(amount: fireMissleAction.power * Constants.missileStrikeMultiple / 4)
            if isDead(grid[e.row][e.col]!) {
                tank.addEnergy(amount: currentEnergy / 4)
            }
        }
    }
}
    
    


