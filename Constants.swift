//
//  Constants.swift
//  TankLand
//
//  Created by Minghan's on 5/2/18.
//  Copyright © 2018 Minghan's. All rights reserved.
//

import Foundation

struct Constants {
    static let initialTankEnergy = 100000
    static let costOfRadarByUnitDistance = [0,100,200,400,800,1600,6400,12400]
    static let costOfSendingMessage = 100
    static let costOfReceivingMessage = 100
    static let costOfReleasingMine = 250
    static let costOfReleasingRover = 500
    static let costOfLaunchingMissle = 1000
    static let costOfFlyingMisslePerUnitDistance = 200
    static let costOfFMovingTanksPerUnitDistance = [100,300,600]
    static let costOfMovingRover = 50
    static let costLiveSupportTank = 100
    static let costLiveSupportRover = 40
    static let costLiveSupportMine = 20
    static let missileStrikeMultiple = 10
    static let missileStrikeMultipleCollateral = 3
    static let mineStrikeMultiple = 5
    static let shieldPowerMultiple = 8
    static let missileStrikeEnergyTransferFraction = 4
}
