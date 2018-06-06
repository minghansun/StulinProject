import Foundation
//import Glibc


class tankSY : Tank { //this is our tank
    override init(row: Int, col: Int, energy: Int, id: String, instructions: String) {
        super.init(row: row, col: col, energy: energy, id: id, instructions: instructions)
    }

    /*func getRandomInt (range: Int) -> Int {
        return Int(rand()) % range
    }*/
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
        addPreAction(preAction: RadarAction(range: 3))
        super.computePreActions()
    }

    override func computePostActions() {
        addPostAction(postAction: MoveAction(distance: 1, direction: .east))

        super.computePostActions()

    }
}

class fire: Tank {
    
    override func computePreActions() {
        addPreAction(preAction: RadarAction(range: 3))
    }
    override func computePostActions() {
        addPostAction(postAction: MissileAction(power: 100, destination: Position(3, 5)))
        super.computePostActions()
    }
}
