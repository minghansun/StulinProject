import Foundation
/*import Glibc*/

struct Logger{
     var data = [Int : [String]]()
     private (set) var round = 1

    mutating func addLog(_ tank: Tank, _ message: String) {
        var log = ""
        log += tank.id + " "
        log += tank.position.description + " "
        log += message
        
        if data[round] == nil {
            data[round] = [String]()
            data[round]!.append(log)
        }
        else {data[round]!.append(log)}
    }

    mutating func newRound () {
        round += 1
    }
}
