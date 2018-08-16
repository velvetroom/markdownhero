import UIKit

class ItalicsInterpreter:Interpreter {
    let match:[String]
    
    init() {
        self.match = ["*", "_"]
    }
    
    func update(font:UIFont) -> UIFont {
        return self.update(font:font, traits:UIFontDescriptor.SymbolicTraits.traitItalic)
    }
}
