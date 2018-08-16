import Foundation

struct StackItem {
    let interpreter:Traits
    let format:[Parser.Format:AnyObject]
    
    init(interpreter:Traits, format:[Parser.Format:AnyObject]) {
        self.interpreter = interpreter
        self.format = format
    }
}
