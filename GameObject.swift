//
//  GameObject.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

enum GameObjectType {
    case GameObject, Tank, Mine, Rover
}

class GameObject : CustomStringConvertible {
    let objectType : GameObjectType
    private (set) var energy: Int
    let id : String
    private (set) var position: Position
    
    init(row: Int, col: Int, objectType: GameObjectType, energy: Int, id: String) {
        self.objectType = objectType
        self.energy = energy
        self.id = id
        self.position = Position(row, col)
    }
    
    final func addEnergy (amount: Int) {
        energy += amount
    }
    
    final func useEnergy (amount: Int) {
        energy -= amount
    }
    
    final func setPosition (newPosition: Position) {
        position = newPosition
    }
    
    var description: String {
        return "\(objectType) \(energy) \(id) \(position)"
    }
}


