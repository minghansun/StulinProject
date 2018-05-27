import Foundation
/*import Glibc*/

struct Logger{
    var data: [Int : [String]]
    var round = 1

    func addLog(_ tank: Tank, _ message: String){
        var log = ""
        log += tank.id + " "
        log += tank.position.description + " "
        log += message
    }

    mutating func newRound(){
        round += 1
    }
}
