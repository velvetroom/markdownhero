import UIKit

class ItalicsTraits:Traits {
    let match:[String]
    
    init() {
        self.match = ["*", "_"]
    }
    
    func update(format:[Parser.Format:AnyObject]) -> [Parser.Format:AnyObject] {
        return self.update(original:format, traits:Parser.Traits.traitItalic)
    }
}
