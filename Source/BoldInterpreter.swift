import UIKit

class BoldInterpreter:Interpreter {
    let match:[String]
    
    init() {
        self.match = ["**", "__"]
    }
    
    func update(font:UIFont) -> UIFont {
        return self.update(font:UIFont.systemFont(ofSize:font.pointSize, weight:UIFont.Weight.heavy),
                           traits:font.fontDescriptor.symbolicTraits)
    }
}
