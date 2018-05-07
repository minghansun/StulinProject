//
//  TankWorldSupport.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

extension TankWorld {
    func newPosition (position: Position, direction: Direction, magnitude k: Int) -> Position{
        let x = position.row
        let y = position.col
        switch direction {
        case .north: return Position(x - k, y)
        case .south: return Position(x + k, y)
        case .west: return Position(x, y - k)
        case .east: return Position(x, y + k)
        case .northeast: return Position(x - k, y + k)
        case .northwest: return Position(x - k, y - k)
        case .southeast: return Position(x + k, y + k)
        case .southwest: return Position(x + k, y - k)
        }
    }
    
    func isGoodIndex (_ row: Int, _ col: Int) -> Bool {
        return row <= 14 && col <= 14 && row >= 0 && col >= 0
    }
    
    func isValidPosition (_ position: Position) -> Bool {
        return isGoodIndex(position.row, position.col)
    }
    
    func distance (_ p1: Position, _ p2: Position) -> Int {
        let roughResult = Double((p1.row - p2.row) * (p1.row - p2.row) + (p1.col - p2.col) * (p1.col - p2.col))
        return Int(sqrt(roughResult))
    }
    
    func isDead (_ gameObject: GameObject) -> Bool {
        return gameObject.energy < 0
    }
    
    func isEnergyAvailable (_ gameObject: GameObject, amount: Int) -> Bool {
        return gameObject.energy > amount
    }
    
    func isPositionEmpty (_ position: Position) -> Bool {
        return grid[position.row][position.col] == nil
    }
    
    func findAllGameObjects () -> [GameObject] {
        var result = [GameObject]()
        for e in grid {
            for j in 0...14 {
                if e[j] != nil {
                    result.append(e[j]!)
                }
            }
        }
        return result
    }
    
    /*func getLegalSurroundingPositions (_ position: Position) -> [Position] {
        var result = [Position]()
        result[0] = newPosition(position: position, direction: .north, magnitude: 1)
        result[1] = newPosition(position: position, direction: .south, magnitude: 1)
        result[2] = newPosition(position: position, direction: .east, magnitude: 1)
        result[3] = newPosition(position: position, direction: .west, magnitude: 1)
        result[4] = newPosition(position: position, direction: .northwest, magnitude: 1)
        result[5] = newPosition(position: position, direction: .northeast, magnitude: 1)
        result[6] = newPosition(position: position, direction: .southwest, magnitude: 1)
        result[7] = newPosition(position: position, direction: .southeast, magnitude: 1)
        return result.filter{isValidPosition($0)}
    }*/
}
