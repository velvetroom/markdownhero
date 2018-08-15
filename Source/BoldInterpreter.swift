import UIKit

class BoldInterpreter:InterpreterProtocol {
    let match:[String]
    
    init() {
        self.match = ["**", "__"]
    }
    
    func attributes(original:[NSAttributedString.Key:AnyObject]) -> [NSAttributedString.Key:AnyObject] {
        return self.update(original:original, traits:UIFontDescriptor.SymbolicTraits.traitBold)
    }
}
