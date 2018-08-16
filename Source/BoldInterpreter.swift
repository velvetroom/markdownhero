import UIKit

class BoldInterpreter:Interpreter {
    let match:[String]
    
    init() {
        self.match = ["**", "__"]
    }
    
    func update(format:[Parser.Format:AnyObject]) -> [Parser.Format:AnyObject] {
        return self.update(original:format, traits:Parser.Traits.traitBold)
    }
}
