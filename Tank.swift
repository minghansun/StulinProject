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
    
    override func liveSupport () {
        useEnergy(amount: Constants.costLiveSupportTank)
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

class tankSY : Tank { //this is our tank
    override init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        super.init(row: row, col: col, energy: energy, id: id, instructions: instructions)
    }
    
    func getRandomInt (range: Int) -> Int {
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    func randomizeDirection () -> Direction {
        var directions = [Direction]()
        directions.append(.north)
        directions.append(.south)
        directions.append(.east)
        directions.append(.west)
        directions.append(.northwest)
        directions.append(.northeast)
        directions.append(.southeast)
        directions.append(.southeast)
        return directions[getRandomInt(range: 7)]
    }
    
    func chanceOf (percent: Int) -> Bool {
        let ran = getRandomInt(range: 100)
        return percent <= ran
    }
    
    override func computePreActions() {
        addPreAction(adding: ShieldAction(power: 200))
        addPreAction(adding: RadarAction(range: 4))
        addPreAction(adding: SendMessageAction(key: "123", message: "hello world"))
        super.computePreActions()
    }
    
    override func computePostActions() {
        if chanceOf(percent: 50) {
            addPostAction(adding: MoveAction(distance: 2, direction: randomizeDirection()))
        }
        super.computePostActions()
        guard let rs = radarResults, rs.count != 0 else {return}
        if energy < 5000 {return}
    }
}
