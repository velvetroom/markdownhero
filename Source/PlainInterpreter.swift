import UIKit

class PlainInterpreter:Interpreter {
    let match:[String]
    
    init() {
        self.match = []
    }
    
    func update(font:UIFont) -> UIFont { return font }
}
