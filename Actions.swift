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

struct MissileAction : PostAction {
    let action: Actions
    let power : Int
    let absoluteDestination : Position

    var description: String {
        return "\(action) \(power) \(absoluteDestination)"
    }

    init (power: Int, destination: Position) {
        action = .Missle
        self.power = power
        self.absoluteDestination = destination
    }
}

struct ShieldAction : PreAction {
    let power : Int
    let action : Actions

    var description: String {
        return "\(action) \(power)"
    }

    init (power: Int) {
        action = .Shields
        self.power = power
    }
}

struct RadarAction : PreAction {
    let radius : Int
    let action : Actions

    var description: String {
        return "\(action) \(radius)"
    }

    init (radius: Int) {
        action = .Radar
        self.radius = radius
    }
}

struct RadarResult : CustomStringConvertible{
    var information = [(Position,String,Int)]()
    
    var description: String {
        var string = ""
        for e in information {
            string += "\(e.0) \(e.1) \(e.2)"
        }
        return string
    }
    //this struct needs to be polished
}

struct SendMessageAction : PreAction {
    let key : String
    let message : String
    let action: Actions

    var description: String{
        return "\(key) \(message)."
    }

    init (key: String, message: String) {
        action = .SendMessage
        self.key = key
        self.message = message
    }
}

struct ReceiveMessageAction : PreAction {
    let action: Actions
    let key: String
    var description: String{
        return "\(action) \(key)"
    }
    init (key: String) {
        action = .ReceiveMessage
        self.key = key
    }
}

struct DropMineAction {
    let action : Actions
    let isRover : Bool
    let power: Int
    let dropDirection : Direction?
    let moveDirection : Direction?
    let id : String
    
    var description : String {
        let dropDirectionMessage = (dropDirection == nil) ? "drop direction is random" : "\(dropDirection!)"
        let moveDirectionMessage = (moveDirection == nil) ? "move direction is random" : "\(moveDirection!)"
        return "\(action) \(power) \(dropDirectionMessage) \(isRover) \(moveDirectionMessage)"
    }
    
    init (power: Int, isRover: Bool = false, dropDirection: Direction? = nil, moveDirection: Direction? = nil, id: String) {
        action = .DropMine
        self.isRover = isRover
        self.dropDirection = dropDirection
        self.moveDirection = moveDirection
        self.power = power
        self.id = id
    }
}

enum Actions {
    case SendMessage, ReceiveMessage, Radar, Shields, DropMine, Missle, Move
}
