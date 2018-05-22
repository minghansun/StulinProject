//
//  Tank.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

class Tank : GameObject {
    var shield = 0
    private var receivedMessage: String?
    private (set) var preActions = [Actions: PreAction]()
    private (set) var postActions = [Actions: PostAction]()
    let initialInstructions: String?
    private (set) var radarResults: [RadarResult]?
    
    init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        initialInstructions = instructions
        super.init(row: row, col: col, objectType: .Tank, energy: energy, id: id)
    }
    
    final func addEnergyToShield (amount: Int) {
        shield += amount
    }
    
    final func clearShieldEnergy () {
        shield = 0
    }
    
    final func newRadarResult (result:  RadarResult?) {
        radarResults?.append(result!) //could be a source of error
    }
    
    final func clearActions () {
        preActions = [Actions: PreAction]()
        postActions = [Actions: PostAction]()
    }
    
    final func receiveMessage (message: String) {
        receivedMessage = message
    }
    
    func computePreActions () {
        
    }
    
    func computePostActions () {
        
    }
    
    final func addPreAction (adding preAction: PreAction) {
        preActions[preAction.action] = preAction
    }
    
    final func addPostAction (adding postAction: PostAction) {
        postActions[postAction.action] = postAction
    }
}

class Mine : GameObject {
    init(mineorRover: GameObjectType, row: Int, col: Int, energy: Int, id: String) {
        super.init(row: row, col: col, objectType: mineorRover, energy: energy, id: id)
    }
}

//how to combine mine and rover is a tough question. 
