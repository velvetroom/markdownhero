import UIKit

class PlainTraits:Traits {
    let match:[String]
    
    init() {
        self.match = []
    }
    
    func update(format:[Parser.Format:AnyObject]) -> [Parser.Format:AnyObject] {
        return format
    }
}
