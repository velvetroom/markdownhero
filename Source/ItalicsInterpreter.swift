import UIKit

class ItalicsInterpreter:InterpreterProtocol {
    let match:[String]
    
    init() {
        self.match = ["*", "-"]
    }
    
    func attributes(original:[NSAttributedString.Key:AnyObject]) -> [NSAttributedString.Key:AnyObject] {
        return self.update(original:original, traits:UIFontDescriptor.SymbolicTraits.traitItalic)
    }
}
