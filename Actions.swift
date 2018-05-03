//
//  Actions.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

protocol Action: CustomStringConvertible {
    var action: Actions {get}
    var description: String {get}
}

protocol PreAction: Action {
    
}

protocol PostAction: Action {
    
}

struct MoveAction : PostAction {
    let action: Actions
    let distance : Int
    let direction : Direction
    
    var description: String {
        return "\(action) \(distance) \(direction)"
    }
    
    init(distance: Int, direction: Direction) {
        action = .Move
        self.distance = distance
        self.direction = direction
    }
}

struct FireMissileAction : PostAction {
    let action: Actions
    let energy : Int
    let absoluteDestination : Position
    
    var description: String {
        return "\(absoluteDestination) \(energy)"
    }
    
    init (energy: Int, destination: Position) {
        action = .FireMissle
        self.energy = energy
        self.absoluteDestination = destination
    }
}

struct SetShieldsPreAction : PreAction {
    let energy : Int
    let action : Actions

    var description: String {
        return "\(energy)"
    }
    
    init (energy: Int) {
        action = .SetShields
        self.energy = energy
    }
}

struct runRadarPreAction : PreAction {
    let radius : Int
    let action : Actions
    
    var description: String {
        return "\(radius)"
    }
    
    init (radius: Int) {
        action = .RunRadar
        self.radius = radius
    }
}

struct sendMessagePreAction : PreAction {
    let idCode : String
    let text : String
    let action: Actions
    
    var description: String {
        return "\(idCode) \(text)."
    }
    
    init (id: String, text: String) {
        action = .SendMessage
        idCode = id
        self.text = text
    }
}

enum Actions {
    case SendMessage, ReceiveMessage, RunRadar, SetShields, DropMine, DropRover, FireMissle, Move
}


