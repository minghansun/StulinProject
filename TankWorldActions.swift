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
    
    func actionRunRadar (tank: Tank, runRadarAction: runRadarAction) {
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
    }
    
    func actionSetShield (tank: Tank, setShieldsAction: SetShieldsAction) {
        if isDead(tank) {return}
        
        if !isEnergyAvailable(tank, amount: setShieldsAction.energy) {
            return
        }
        
        tank.addEnergyToShield(amount: setShieldsAction.energy)
    }
    
    func actionMove (tank: Tank, moveAction: MoveAction) {
        if isDead(tank) {return}
        
        if !isEnergyAvailable(tank, amount: Constants.costOfFMovingTanksPerUnitDistance[moveAction.distance]) {
            return
        }
        
        tank.setPosition(newPosition: newPosition(position: tank.position, direction: moveAction.direction, magnitude: moveAction.distance))
    }
    
    
}

