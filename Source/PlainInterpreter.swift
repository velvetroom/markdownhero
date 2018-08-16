import UIKit

class PlainInterpreter:Interpreter {
    let match:[String]
    
    init() {
        self.match = []
    }
    
    func update(format:[Parser.Format:AnyObject]) -> [Parser.Format:AnyObject] {
        return format
    }
}
