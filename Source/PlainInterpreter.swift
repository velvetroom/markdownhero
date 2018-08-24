import UIKit

class PlainInterpreter:Interpreter {
    let match:[String]
    
    init() {
        match = []
    }
    
    func update(font:UIFont) -> UIFont { return font }
}
