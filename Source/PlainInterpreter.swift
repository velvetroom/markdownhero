import UIKit

class PlainInterpreter:InterpreterProtocol {
    let match:[String]
    
    init() {
        self.match = []
    }
    
    func attributes(original:[NSAttributedString.Key:AnyObject]) -> [NSAttributedString.Key:AnyObject] {
        return original
    }
}
