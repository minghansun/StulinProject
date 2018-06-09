//
//  Tank.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation
//import Glibc


class Tank : GameObject {
    private (set) var shield = 0
    private var receivedMessage: String?
    private (set) var preActions = [Actions: PreAction]()
    private (set) var postActions = [Actions: PostAction]()
    let initialInstructions: String?
    private (set) var radarResults =  [RadarResult]()
    private (set) var Turn = 1 // for testing

    init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        initialInstructions = instructions
        super.init(row: row, col: col, objectType: .Tank, energy: energy, id: id)
    }
    
    final func newTurn () { // for testing
        Turn += 1
    }

    override func liveSupport () {
        useEnergy(amount: Constants.costLiveSupportTank)
    }

    final func addEnergyToShield (amount: Int) {
        shield += amount
    }

    final func depleteEnergyFromShield (amount: Int) {
        shield -= amount
    }
    
    final func clearShieldEnergy () {
        shield = 0
    }

    final func newRadarResult (result:  RadarResult) {
        radarResults.append(result) //could be a source of error
    }

    final func clearActions () {
        preActions = [Actions: PreAction]()
        postActions = [Actions: PostAction]()
    }

    final func setReceivedMessage (message: String) {
        receivedMessage = message
    }

    func computePreActions () {

    }

    func computePostActions () {

    }

    final func addPreAction (preAction: PreAction) {
        preActions[preAction.action] = preAction
    }

    final func addPostAction (postAction: PostAction) {
        postActions[postAction.action] = postAction
    }
}

class Mine : GameObject {
    let moveDirection : Direction?

    init(mineorRover: GameObjectType, row: Int, col: Int, energy: Int, id: String, moveDirection: Direction?) {
        self.moveDirection = moveDirection
        super.init(row: row, col: col, objectType: mineorRover, energy: energy, id: id)
    }

    override func liveSupport () {
        if objectType == .Mine {
            useEnergy(amount: Constants.costLiveSupportMine)
        }
        else {
            useEnergy(amount: Constants.costLiveSupportRover)
        }
    }
}
