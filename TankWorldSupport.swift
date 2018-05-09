//
//  TankWorldSupport.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

extension TankWorld {
    func newPosition (position: Position, direction: Direction, magnitude k: Int) -> Position {
        
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
    
    func applyCost (_ object: GameObject, amount: Int) {
        object.useEnergy(amount: amount)
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
    
    func getLegalSurroundingPositions (_ position: Position) -> [Position] {
        var result = [Position]()
        result.append(newPosition(position: position, direction: .north, magnitude: 1))
        result.append(newPosition(position: position, direction: .south, magnitude: 1))
        result.append(newPosition(position: position, direction: .east, magnitude: 1))
        result.append(newPosition(position: position, direction: .west, magnitude: 1))
        result.append(newPosition(position: position, direction: .northwest, magnitude: 1))
        result.append(newPosition(position: position, direction: .northeast, magnitude: 1))
        result.append(newPosition(position: position, direction: .southwest, magnitude: 1))
        result.append(newPosition(position: position, direction: .southeast, magnitude: 1))
        return result.filter{isValidPosition($0)}
    }
    
    func findObjectsWithinRange (_ position: Position, range: Int) -> [Position] {
        var result = [Position]()
        for e in 0...14 {
            for h in 0...14 {
                if grid[e][h] != nil && distance(position, Position(e,h)) <= range {
                    result.append(grid[e][h]!.position)
                }
            }
        }
        return result
    }
    
    func findAllTanks () -> [Tank] {
        return findAllGameObjects().filter{$0.objectType == .Tank} as! [Tank]
    }
    
    func findAllRovers () -> [Mine] {
        return findAllGameObjects().filter{$0.objectType == .Rover} as! [Mine]
    }
    
    func findWinner () -> Tank? {
        if findAllTanks().count == 1 {
            return findAllTanks()[0]
        }
        return nil
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
    
    func getRandomInt (range: Int) -> Int {
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    /*func getRandomInt (range: Int) -> Int {
        return Int(rand()) % range
    }*/
    //this code is for Linux
}
