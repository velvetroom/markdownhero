import UIKit

class ItalicsInterpreter:Interpreter {
    let match = ["*", "_"]
    
    func update(font:UIFont) -> UIFont {
        return update(font:font, traits:.traitItalic)
    }
}
