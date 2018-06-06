import Foundation
/*import Glibc*/

struct Logger{
     var data = [Int : [String]]()
     private (set) var round = 1

    mutating func addLog(_ obj: GameObject, _ message: String) {
        var log = ""
        log += obj.id + " "
        log += obj.position.description + " "
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
