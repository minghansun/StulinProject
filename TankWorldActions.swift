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

        //applyCost(tank, amount: Constants.costOfSendingMessage)
        //MessageCenter.sendMessage()
    }

    func actionReceiveMessage(tank: Tank, receiveMessageAction: ReceiveMessageAction){
        if isDead(tank){return}
        //logger.addLog(tank, "Receiving Message \(receiveMessageAction)")

        if !isEnergyAvailable(tank, amount: Constants.costOfReceivingMessage){
            //logger.addLog(tank, "Insufficient energy to send message")
            return
        }

        //applyCost(tank, amount: Constants.costOfReceivingMessage)
        //let message = MessageCenter.receiveMessage(id: receiveMessageAction.id)
        //tank.setReceivedMessage(receivedMessage: message)

    }
}
