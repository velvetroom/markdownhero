import UIKit

class BoldInterpreter:Interpreter {
    let match:[String]
    
    init() {
        match = ["**", "__"]
    }
    
    func update(font:UIFont) -> UIFont {
        return update(font:UIFont.systemFont(ofSize:font.pointSize, weight:.heavy),
                      traits:font.fontDescriptor.symbolicTraits)
    }
}
